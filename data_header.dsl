--host --url $HOST
--tenant_login
--delete_tenant --name $TENANT
--delete_tenant_mapping --tenant $TENANT
--tenant_mapping --domain $DOMAIN --tenant $TENANT
--create_tenant --name $TENANT
--registration --email admin@$DOMAIN --pass 123123123 --api_access true --role admin --self_service_storage {'role':'admin'}
--registration --email user@$DOMAIN --pass 123123123 --api_access true --role user --self_service_storage {'role':'user'}
