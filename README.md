# marvel_api

## Requires rails 6 or higher and ruby 2.7 or higher

## To install all depedencies:
```
bundle install
```

## To initialize and run migrations on db:
### First go to config/initializers/initialize_database.rb and comment the entire file
### then
```
rake db:migrate
```
### now go back to config/initializers/initialize_database.rb and uncomment it

## To start server:

```
rails s
```


## When running for the first time, it may take some minutes because the server gets all characters from marvel api and storages them.
