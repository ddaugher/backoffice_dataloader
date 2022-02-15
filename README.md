# backoffice_dsl

## introduction
The backoffice_dsl repository provides utilities to manage instances of backoffice services.  The scripts contained within this repository utilize the standard backoffice ReST services to facilitate the management of bulk customer data.

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

## process_DSL
The script, *process_DSL.sh*, will process a DSL input file.  The file has all of the full features of the DSL.  A common use for the script is to delete/create a new tenanat, with base data for a potentially new customer.

By default, the script does NOT take command line parameters and will prompt the user for required input values.

execute the script with the ```-H``` option in order to view the ```DSL options``` information.
```
==> ./process_DSL.sh
```

output... 

```
NOT GOING TO LIST IT HERE... will be stale too quick. Use the script to generate the '-h' options.
``` 

---

you can execute the script in the following manner if you would like to not type each request.
```
 ==> printf 'LOCAL\nbase\n' | ./process_DSL.sh
 ```
 
 This will pass 'LOCAL' and 'base' to the input questions in respective order.
   
 example output...
 
```
==> printf 'LOCAL\nbase\n' | ./process_DSL.sh
--- LOCAL
--- DEV
--- STAGE
--- PROD
Enter name of ENV to apply (enter Q to quit): [LOCAL]
Setting ENV -> LOCAL
--------------------------------------> LOCAL
--- base
--- leadingagile
--- sunfloweruat
Enter name of TENANT to apply (enter Q to quit): [1]
base
base exists... continuing!
-----------------------------------------------------------------------------------------
incoming line from file : --host --url http://localhost:4000
input line : --host
processing host -> http://localhost:4000
-----------------------------------------------------------------------------------------
incoming line from file : --tenant_login
input line : --tenant_login
processing username -> tenantloader@nxdomain.com
processing password -> 123123123
--- Creating session -> tenantloader@nxdomain.com 123123123
```