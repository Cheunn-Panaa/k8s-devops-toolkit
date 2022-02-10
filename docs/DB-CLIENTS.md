# DBClients

Will Install mysql client and mssql client programs

```bash
# Bind Current Namespace MySQL db instance on port 3308
binddb 3308 

# Connect to Current Namespace MySQL db instance on port 3308
cnxdb 3308

# MSSQL DB Chiffrée
## Créer une DB et le user admin associé
CREATE DATABASE val_data_g
USE val_data_g
CREATE LOGIN admin_val_data_g WITH PASSWORD = 'MotDePasse'
CREATE USER admin_val_data_g FOR LOGIN admin_val_data_g
ALTER ROLE db_owner ADD MEMBER admin_val_data_g
go

## Get Current DB
select DB_NAME()
GO

#s#how databases;
select name from sys.databases
go

## drop database 
drop database [mydbname]
go

##Se connecter à la base
sqlcmd -S mssql-staging.dolmen.systems -U admin_val_data_g -P MotDePasse
```
