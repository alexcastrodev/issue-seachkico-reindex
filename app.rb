# single_file_test.rb

require 'active_record'
require 'minitest/autorun'
require 'searchkick'
require 'opensearch-ruby'

ActiveRecord::Base.establish_connection(
  adapter: "postgresql",
  encoding: "unicode",
  database: "postgres",
  username: "postgres",
  password: "",
  host: "postgres",
)

OpenSearchClient = OpenSearch::Client.new(
  host: 'http://searchkick:9200',
  user: 'admin',
  password: 'admin',
  transport_options: { ssl: { verify: false } }  # For testing only. Use certificate for validation.
)

Searchkick.client = OpenSearchClient


class CreateCustomerTable < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :name

      t.timestamps
    end

    create_table :products do |t|
      t.string :title

      t.timestamps
    end
  end
end


class Customer < ActiveRecord::Base
  searchkick
  after_create_commit :force_reindex

  def force_reindex
    self.reindex(mode: :inline)
  end
end


class Product < ActiveRecord::Base
  searchkick
  after_create_commit :force_reindex

  def force_reindex
    self.reindex(mode: :inline, refresh: true)
  end
end

class CustomerTest < Minitest::Test
  def setup
    CreateCustomerTable.migrate(:up)
    Customer.reindex
    Product.reindex
  end

  def teardown
    CreateCustomerTable.migrate(:down)
  end

  def test_customer_creation
    Customer.create(name: "pé de cueco")
    Customer.create(name: "cueco es hueco")

    search = Customer.search("*")

    assert_equal 0, search.results.length
  end

  def test_product_creation
    Product.create(title: "Pablo peter")
    Product.create(title: "MC poze")

    search = Product.search("*")

    assert_equal 2, search.results.length
  end
end
