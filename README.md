# backoffice_dataloader

## introduction
The backoffice_dataloader repository provides utilities to manage instances of backoffice services.  The scripts contained within this repository utilize the standard backoffice ReST services to facilitate the management of bulk customer data.

## create api user authorizations
The script, *create_api_user_authorizations.sh*, will batch apply all of the necessary api access privileges for the supplied userid(s).  If new 'access authorizations' are created after running this script, running this script again will not cause any damage to the existing settings.

execute the script with no params in order to view the ```usage``` information.
```
==> ./create_api_user_authorizations.sh
```

output... 

```
usage: $PROGRAM_NAME [--token access_token] [-userids ids] [--host hostname]
--host http://localhost:4000     hostname of 'backend' server'
--token access_token             specify access_token received during login
--userids 1 2 4                  list of user ids
```

### access_token
A valid access token is required.  You will need to utilize the ```login``` Backend ReST endpoint in order to obtain using a valid ```username``` and ```password```.

## create default values
The script, *create_api_user_authorizations.sh*, will batch apply updates to the database via the backend ReST api endpoints via the backend DSL.

execute the script with no params in order to view the ```usage``` information.
```
==> ./create_api_user_authorizations.sh
```

output... 

```
usage: $PROGRAM_NAME input_file

 --create_tenant --name [string]
 --customer --name [string] --is_active [true/false]
 --daily_expense_type --name [string]
 --delete_tenant --name [string]
 --employee --first_name [string] --last_name [string] --email [string] --start_date [yyyy-mm-dd] --hourly_cost [decimal] --daily_billable_hours [integer (1-8)] --utilization_target [decimal] --employee_type_id [id] --region_id [id]
 --employee_type --name [string] --is_employee [true/false] --is_utilized [true/false]
 --holiday --date [yyyy-mm-dd] --description [string] --hours [integer (1-8)] --work_exception_type_id [id]
 --host --url [url]
 --login --username [string] --password [string]]
 --monthly_expense_type --name [string]
 --open_position --name [string] --start_date [yyyy-mm-dd] --end_date [yyyy-mm-dd] --bill_rate [decimal] --cost [decimal] --daily_billable_hours [integer (1-8)] --project_id [id] --position_type_id [id]
 --position_monthly_expense --month [integer] --year [integer] --cost [decimal] --description [string] --position_id [id] --monthly_expense_type_id [id]
 --position_daily_expense --cost [decimal] --description [string] --position_id [id] --monthly_expense_type_id [id]
 --position_type --name [string]
 --position_with_employee --name [string] --start_date [yyyy-mm-dd] --end_date [yyyy-mm-dd] --bill_rate [decimal] --cost [decimal] --daily_billable_hours [integer (1-8)] --project_id [id] --position_type_id [id] --employee_id [id]
 --project --name [string] --customer_id [id] --region_id [id] --status [string]
 --region --name [string]
 --registration --user [string] --pass [string] --api_access [true/false] --role [string (user/admin)] --tenant [string]
 --release_version --version [string] --notes [string]
 --renew
 --tenant_mapping --domain [string] --tenant [string]
 --work_exception --description [string] --date [yyyy-mm-dd] --employee_id [id] --work_exception_type_id [id] --hours [integer (1-8)]
 --work_exception_type --name [string]
``` 