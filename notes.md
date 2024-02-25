# Notes

## Starting a dbt project
```bash

# initialize the dbt project
# set connections as defined in env
dbt init projectname

# check if everything worked
cd projectname
dbt debug

```


## Models

- Definitions of tables, views, .. as SQL Files


## Materializations

### view
- views are not automatically dropped by dbt

### table

### Incremental
- rebuild every incremental table with dbt run --full-refresh

## Ephemeral
