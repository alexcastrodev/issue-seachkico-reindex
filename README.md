# Sickkick issue



# How to test

Open in devcontainer

## Install dependencies

```bash
bundle install
```

## Test the app

```bash
ruby app.rb
```


# Actual result

```bash
vscode ➜ /workspaces/issue_searchkicko (main) $ ruby app.rb 
Run options: --seed 25954

# Running:

==  CreateCustomerTable: migrating ============================================
-- create_table(:customers)
   -> 0.0336s
-- create_table(:products)
   -> 0.0053s
==  CreateCustomerTable: migrated (0.0391s) ===================================

==  CreateCustomerTable: reverting ============================================
-- drop_table(:products)
   -> 0.0029s
-- drop_table(:customers)
   -> 0.0026s
==  CreateCustomerTable: reverted (0.0107s) ===================================

.==  CreateCustomerTable: migrating ============================================
-- create_table(:customers)
   -> 0.0042s
-- create_table(:products)
   -> 0.0054s
==  CreateCustomerTable: migrated (0.0097s) ===================================

==  CreateCustomerTable: reverting ============================================
-- drop_table(:products)
   -> 0.0028s
-- drop_table(:customers)
   -> 0.0022s
==  CreateCustomerTable: reverted (0.0052s) ===================================

.

Finished in 1.198735s, 1.6684 runs/s, 1.6684 assertions/s.

2 runs, 2 assertions, 0 failures, 0 errors, 0 skips
```