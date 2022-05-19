#!/usr/bin/env bash

source ./configs.sh
source ./functions.sh
source ./kv-sh
source ./logging_lib.sh

ALL_ENVS=(LOCAL DEV STAGE PROD)
ALL_LOGGING=(VERBOSE DEBUG INFO WARN ERROR FATAL)
export ENV=''
export TENANT=BASE

ACCESS_TOKEN=''
export HOST=''
export DOMAIN=''
PROGRAM_NAME=$0
RENEWAL_TOKEN=''
CURL='/usr/bin/curl'

gather_HOST() {
   if [ "$ENV" == LOCAL ]; then
      log_info "Setting host: http://localhost:4000"
      export HOST="http://localhost:4000"
   elif [ "$ENV" == DEV ]; then
      log_info "Setting host: https://backofficedev.gigalixirapp.com"
      export HOST="https://backofficedev.gigalixirapp.com"
   elif [ "$ENV" == STAGE ]; then
      log_info "Setting host: https://backofficestaging.gigalixirapp.com"
      export HOST="https://backofficestaging.gigalixirapp.com"
   elif [ "$ENV" == PROD ]; then
      log_info "Setting host: https://backofficeprod.gigalixirapp.com"
      export HOST="https://backofficeprod.gigalixirapp.com"
   else
      log_info "Setting host: https://backofficedev.gigalixirapp.com"
      export HOST="https://backofficedev.gigalixirapp.com"
   fi
}

gather_DOMAIN() {
   export DOMAIN=$(echo "$TENANT.com")
   log_info "Setting DOMAIN: $DOMAIN"
}

publish_SLACK() {
   curl -X POST -H 'Content-type: application/json' --data "{'text':'Deploying Backoffice (${ENV})'}" https://hooks.slack.com/services/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
   curl -X POST -H 'Content-type: application/json' --data "{'text':'Setting revision: ${REV}'}" https://hooks.slack.com/services/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
   return 0
}

gather_ENV() {
   let counter=1
   while [ $counter -le ${#ALL_ENVS[@]} ]; do
      echo "--- ${ALL_ENVS[$counter - 1]}"
      let counter++
   done

   echo "Enter name of ENV to apply (enter Q to quit): [LOCAL]"
   read env
   env=${env:-LOCAL}

   if [ $env = "Q" ] || [ $env = "q" ]; then
      exit 0
   fi

   export ENV=$env
   log_info "Setting ENV -> $ENV"
   return 0
}

gather_VERSION() {
   echo "Enter name of VERSION to apply (enter Q to quit): [v1.0.0]"
   read version
   version=${version:-v1.0.0}

   if [ $version = "Q" ] || [ $version = "q" ]; then
      exit 0
   fi

   export VERSION=$version
   log_info "Setting VERSION -> $VERSION"
   return 0
}

gather_NOTES() {
   echo "Enter NOTES for $VERSION to apply (enter Q to quit): []"
   read notes
   notes=${notes:-}

   if [ $notes = "Q" ] || [ $notes = "q" ]; then
      exit 0
   fi

   export NOTES="$notes"
   log_info "NOTES -> $NOTES"
   return 0
}

gather_LOGGING() {
   let counter=1
   while [ $counter -le ${#ALL_LOGGING[@]} ]; do
      echo "--- ${ALL_LOGGING[$counter - 1]}"
      let counter++
   done

   echo "Enter LOGGING LEVEL to apply (enter Q to quit): [INFO]"
   read logging
   logging=${logging:-INFO}

   if [ $logging = "Q" ] || [ $logging = "q" ]; then
      exit 0
   fi

   export LOGGING=$logging
   log_info "Setting LOGGING -> $LOGGING"
   set_log_level $LOGGING
   return 0
}

gather_TENANTS() {
   ALL_TENANTS=($(
      cd tenants
      ls -d */ | cut -f1 -d'/'
   ))

   let counter=1
   while [ $counter -le ${#ALL_TENANTS[@]} ]; do
      echo "--- ${ALL_TENANTS[$counter - 1]}"
      let counter++
   done

   echo "Enter name of TENANT to apply (enter Q to quit): [base]"
   read tenant
   tenant=${tenant:-base}

   if [ $tenant = "Q" ] || [ $tenant = "q" ]; then
      exit 0
   fi

   export TENANT=$tenant
   log_info "Setting TENANT -> $TENANT"
   return 0
}

function help() {
   clear
   echo "-----------------------------------------------------------------------------------------"
   echo "The following DSL options are available."
   echo ""
   echo " --create_tenant --name [string]"
   echo " --customer --name [string] --is_active [true/false] --uuid [string]"
   echo " --daily_expense_type --name [string] --uuid [string]"
   echo " --delete_tenant --name [string]"
   echo " --employee --first_name [string] --last_name [string] --email [string] --start_date [yyyy-mm-dd] --hourly_cost [decimal] --daily_billable_hours [integer (1-8)] --utilization_target [decimal] --employee_type_id [id] --region_id [id] --uuid [string]"hhh
   echo " --employee_type --name [string] --is_employee [true/false] --is_utilized [true/false] --uuid [string]"
   echo " --global_detail --name [string] --extended_fields [string]"
   echo " --holiday --date [yyyy-mm-dd] --description [string] --hours [integer (1-8)] --work_exception_type_id [id] --uuid [string]"
   echo " --host --url [url]"
   echo " --login --username [string] --password [string]]"
   echo " --tenant_login"
   echo " --monthly_expense_type --name [string] --uuid [string]"
   echo " --open_position --name [string] --start_date [yyyy-mm-dd] --end_date [yyyy-mm-dd] --bill_rate [decimal] --cost [decimal] --daily_billable_hours [integer (1-8)] --project_id [id] --position_type_id [id] --uuid [string]"
   echo " --position_monthly_expense --month [integer] --year [integer] --cost [decimal] --description [string] --position_id [id] --monthly_expense_type_id [id]"
   echo " --position_daily_expense --cost [decimal] --description [string] --position_id [id] --monthly_expense_type_id [id]"
   echo " --position_type --name [string] --uuid [string]"
   echo " --position_with_employee --name [string] --start_date [yyyy-mm-dd] --end_date [yyyy-mm-dd] --bill_rate [decimal] --cost [decimal] --daily_billable_hours [integer (1-8)] --project_id [id] --position_type_id [id] --employee_id [id] --uuid [string]"
   echo " --project_time_material --name [string] --customer_id [id] --region_id [id] --status [string] --uuid [string]"
   echo " --project_retainer --name [string] --customer_id [id] --region_id [id] --status [string] --monthly_amount [decimal] --uuid [string]"
   echo " --project_fixed_bid --name [string] --customer_id [id] --region_id [id] --status [string] --amount [decimal] --uuid [string]"
   echo " --region --name [string] --uuid [string]"
   echo " --registration --email [string] --pass [string] --api_access [true/false] --role [string (user/admin)] --self_service_storage [string]"
   echo " --release_version --version [string] --notes [string]"
   echo " --renew"
   echo " --tenant_mapping --domain [string] --tenant [string]"
   echo " --delete_tenant_mapping --tenant [string]"
   echo " --delete_tenant_mapping --tenant [string]"
   echo " --work_exception --description [string] --date [yyyy-mm-dd] --employee_id [id] --work_exception_type_id [id] --hours [integer (1-8)] --uuid [string]"
   echo " --work_exception_type --name [string] --uuid [string]"
   echo "-----------------------------------------------------------------------------------------"

   exit 1
}

# check whether user supplied -h or --help . If yes display help
if [[ ($1 == "--help") || ($1 == "-h") || ($1 == "-H") ]]; then
   help
   exit 0
fi

function process_params() {
   shift
   while :; do
      log_debug $1
      case "$1" in
      --monthly_amount)
         shift
         export MONTHLY_AMOUNT="$1"
         shift
         ;;
      --amount)
         shift
         export AMOUNT="$1"
         shift
         ;;
      --url)
         shift
         export HOST="$1"
         shift
         ;;
      --tenant)
         shift
         export TENANT="$1"
         shift
         ;;
      --domain)
         shift
         export DOMAIN="$1"
         shift
         ;;
      --username)
         shift
         USERNAME="$1"
         shift
         ;;
      --user)
         shift
         USER="$1"
         shift
         ;;
      --password)
         shift
         PASSWORD="$1"
         shift
         ;;
      --pass)
         shift
         PASS="$1"
         shift
         ;;
      --role)
         shift
         ROLE="$1"
         shift
         ;;
      --email)
         shift
         EMAIL="$1"
         shift
         ;;
      --start_date)
         shift
         START_DATE="$1"
         shift
         ;;
      --date)
         shift
         DATE="$1"
         shift
         ;;
      --end_date)
         shift
         END_DATE="$1"
         shift
         ;;
      --month)
         shift
         MONTH="$1"
         shift
         ;;
      --year)
         shift
         YEAR="$1"
         shift
         ;;
      --bill_rate)
         shift
         BILL_RATE="$1"
         shift
         ;;
      --cost)
         shift
         COST="$1"
         shift
         ;;
      --daily_billable_hours)
         shift
         DAILY_BILLABLE_HOURS="$1"
         shift
         ;;
      --hours)
         shift
         HOURS="$1"
         shift
         ;;
      --hourly_cost)
         shift
         HOURLY_COST="$1"
         shift
         ;;
      --api_access)
         shift
         API_ACCESS="$1"
         shift
         ;;
      --is_active)
         shift
         IS_ACTIVE="$1"
         shift
         ;;
      --is_employee)
         shift
         IS_EMPLOYEE="$1"
         shift
         ;;
      --is_utilized)
         shift
         IS_UTILIZED="$1"
         shift
         ;;
      --utilization_target)
         shift
         UTILIZATION_TARGET="$1"
         shift
         ;;
      --work_exception_type_id)
         shift
         WORK_EXCEPTION_TYPE_ID="$1"
         shift
         ;;
      --monthly_expense_type_id)
         shift
         MONTHLY_EXPENSE_TYPE_ID="$1"
         shift
         ;;
      --project_id)
         shift
         PROJECT_ID="$1"
         shift
         ;;
      --position_type_id)
         shift
         POSITION_TYPE_ID="$1"
         shift
         ;;
      --position_id)
         shift
         POSITION_ID="$1"
         shift
         ;;
      --employee_id)
         shift
         EMPLOYEE_ID="$1"
         shift
         ;;
      --customer_id)
         shift
         CUSTOMER_ID="$1"
         shift
         ;;
      --region_id)
         shift
         REGION_ID="$1"
         shift
         ;;
      --employee_type_id)
         shift
         EMPLOYEE_TYPE_ID="$1"
         shift
         ;;
      --version)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            VERSION="$1"
            shift
         done
         ;;
      --notes)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            TEMP="$TEMP $1"
            shift
         done
         NOTES=$TEMP
         echo $NOTES
         ;;
      --name)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            NAME="$NAME $1"
            shift
         done
         ;;
      --uuid)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            UUID="$UUID $1"
            shift
         done
         ;;
      --extended_fields)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            EXTENDED_FIELDS="$EXTENDED_FIELDS $1"
            shift
         done
         ;;
      --self_service_storage)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            SELF_SERVICE_STORAGE="$SELF_SERVICE_STORAGE $1"
            shift
         done
         ;;
      --status)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            STATUS="$STATUS $1"
            shift
         done
         ;;
      --description)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            DESCRIPTION="$DESCRIPTION $1"
            shift
         done
         ;;
      --first_name)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            FIRST_NAME="$FIRST_NAME $1"
            shift
         done
         ;;
      --last_name)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            LAST_NAME="$LAST_NAME $1"
            shift
         done
         ;;
      -*)
         # Unexpected option
         exit 1
         ;;
      *)
         break
         ;;
      esac
   done
}

function process_input() {
   sleep 0
   log_debug "input line : $1"
   case "$1" in
   --host)
      log_debug "processing host -> $HOST"
      ;;
   --tenant_login)
      log_debug "processing tenant_login ---"
      log_debug "processing username -> $TENANT_USERNAME"
      log_debug "processing password -> $TENANT_PASSWORD"
      create_session $TENANT_USERNAME $TENANT_PASSWORD
      ;;
   --release_version)
      log_debug "processing release_version ---"
      process_params $@
      VERSION=$(echo "$VERSION")
      NOTES=$(echo $NOTES)
      log_debug "processing release_versions -> $VERSION"
      log_debug "processing notes -> $NOTES"
      process_release_version "$VERSION" "$NOTES"
      unset VERSION
      unset NOTES
      ;;
   --login)
      log_debug "processing login ---"
      process_params $@
      log_debug "processing username -> $USERNAME"
      log_debug "processing password -> $PASSWORD"
      create_session $USERNAME $PASSWORD
      ;;
   --renew)
      shift
      log_debug "processing renewal token -> $RENEWAL_TOKEN"
      process_renewal $RENEWAL_TOKEN
      ;;
   --registration)
      log_debug "processing registration ---"
      process_params $@
      log_debug "processing email -> $EMAIL"
      log_debug "processing password -> $PASS"
      log_debug "processing api_access -> $API_ACCESS"
      log_debug "processing role -> $ROLE"
      log_debug "processing self service storage -> $SELF_SERVICE_STORAGE"
      SELF_SERVICE_STORAGE=$(echo $SELF_SERVICE_STORAGE)
      process_registration $EMAIL $PASS $API_ACCESS $ROLE "$SELF_SERVICE_STORAGE"
      unset EMAIL
      unset PASS
      unset API_ACCESS
      unset ROLE
      unset SELF_SERVICE_STORAGE
      ;;
   --create_tenant)
      log_debug "processing create_tenant ---"
      process_params $@
      NAME=$(echo $NAME)
      log_debug "processing tenant -> $NAME"
      process_create_tenant "$NAME"
      unset NAME
      ;;
   --delete_tenant)
      log_debug "processing delete_tenant ---"
      process_params $@
      NAME=$(echo $NAME)
      log_debug "processing tenant -> $NAME"
      process_delete_tenant "$NAME"
      unset NAME
      ;;
   --global_detail)
      log_debug "processing global_detail ---"
      process_params $@
      log_debug "processing name -> $NAME"
      log_debug "processing extended_fields -> $EXTENDED_FIELDS"
      process_global_detail "$NAME" "$EXTENDED_FIELDS"
      unset NAME
      unset EXTENDED_FIELDS
      ;;
   --tenant_mapping)
      log_debug "processing tenant_mapping ---"
      process_params $@
      log_debug "processing domain -> $DOMAIN"
      log_debug "processing tenant -> $TENANT"
      process_tenant_mapping $DOMAIN $TENANT
      unset DOMAIN
      unset TENANT
      ;;
   --delete_tenant_mapping)
      log_debug "processing delete_tenant_mapping ---"
      process_params $@
      log_debug "processing tenant -> $TENANT"
      process_delete_tenant_mapping $TENANT
      unset TENANT
      ;;
   --monthly_expense_type)
      log_debug "processing monthly_expense_type ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing monthly_expense_type -> $NAME"
      log_debug "processing uuid -> $UUID"
      process_monthly_expense_type "$NAME" "$UUID"
      unset NAME
      unset UUID
      ;;
   --daily_expense_type)
      log_debug "processing daily_expense_type ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing daily_expense_types -> $NAME"
      log_debug "processing uuid -> $UUID"
      process_daily_expense_type "$NAME" "$UUID"
      unset NAME
      unset UUID
      ;;
   --position_type)
      log_debug "processing position_type ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing position_types -> $NAME"
      log_debug "processing uuid -> $UUID"
      process_position_type "$NAME" "$UUID"
      unset NAME
      unset UUID
      ;;
   --employee_type)
      log_debug "processing employee_type ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing employee type -> $NAME"
      log_debug "processing is_employee -> $IS_EMPLOYEE"
      log_debug "processing is_utilized -> $IS_UTILIZED"
      log_debug "processing uuid -> $UUID"
      process_employee_type "$NAME" $IS_EMPLOYEE $IS_UTILIZED "$UUID"
      unset NAME
      unset IS_EMPLOYEE
      unset IS_UTILIZED
      unset UUID
      ;;
   --customer)
      log_debug "processing customer ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing customer -> $NAME"
      log_debug "processing is_active -> $IS_ACTIVE"
      log_debug "processing uuid -> $UUID"
      process_customer "$NAME" $IS_ACTIVE "$UUID"
      unset NAME
      unset IS_ACTIVE
      unset UUID
      ;;
   --sleep)
      log_debug "processing sleep ---"
      sleep 5
      ;;
   --position_monthly_expense)
      log_debug "processing position_monthly_expense ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      log_debug "processing position -> $DESCRIPTION"
      log_debug "processing month -> $MONTH"
      log_debug "processing year -> $YEAR"
      log_debug "processing cost -> $COST"
      log_debug "processing position_id -> $POSITION_ID"
      log_debug "processing monthly_expense_type_id -> $MONTHLY_EXPENSE_TYPE_ID"
      process_position_monthly_expense $MONTH $YEAR $COST "$DESCRIPTION" $POSITION_ID $MONTHLY_EXPENSE_TYPE_ID
      unset DESCRIPTION
      unset MONTH
      unset YEAR
      unset COST
      unset POSITION_ID
      unset MONTHLY_EXPENSE_TYPE_ID
      ;;
   --open_position)
      log_debug "processing open_position ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing position -> $NAME"
      log_debug "processing start_date -> $START_DATE"
      log_debug "processing end_date -> $END_DATE"
      log_debug "processing bill_rate -> $BILL_RATE"
      log_debug "processing cost -> $COST"
      log_debug "processing daily_billable_hours -> $DAILY_BILLABLE_HOURS"
      log_debug "processing project_id -> $PROJECT_ID"
      log_debug "processing position_type_id -> $POSITION_TYPE_ID"
      log_debug "processing uuid -> $UUID"
      process_open_position "$NAME" $START_DATE $END_DATE $BILL_RATE $COST $DAILY_BILLABLE_HOURS $PROJECT_ID $POSITION_TYPE_ID "$UUID"
      unset NAME
      unset START_DATE
      unset END_DATE
      unset BILL_RATE
      unset COST
      unset DAILY_BILLABLE_HOURS
      unset PROJECT_ID
      unset POSITION_TYPE_ID
      unset UUID
      ;;
   --position_daily_expense)
      log_debug "processing position_daily_expense ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      log_debug "processing position -> $DESCRIPTION"
      log_debug "processing cost -> $COST"
      log_debug "processing position_id -> $POSITION_ID"
      log_debug "processing monthly_expense_type_id -> $MONTHLY_EXPENSE_TYPE_ID"
      process_position_daily_expense $COST "$DESCRIPTION" $POSITION_ID $MONTHLY_EXPENSE_TYPE_ID
      unset DESCRIPTION
      unset COST
      unset POSITION_ID
      unset MONTHLY_EXPENSE_TYPE_ID
      ;;
   --position_with_employee)
      log_debug "processing position_with_employee ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing position -> $NAME"
      log_debug "processing start_date -> $START_DATE"
      log_debug "processing end_date -> $END_DATE"
      log_debug "processing bill_rate -> $BILL_RATE"
      log_debug "processing cost -> $COST"
      log_debug "processing daily_billable_hours -> $DAILY_BILLABLE_HOURS"
      log_debug "processing project_id -> $PROJECT_ID"
      log_debug "processing position_type_id -> $POSITION_TYPE_ID"
      log_debug "processing employee_id -> $EMPLOYEE_ID"
      log_debug "processing uuid -> $UUID"
      process_position_with_employee "$NAME" $START_DATE $END_DATE $BILL_RATE $COST $DAILY_BILLABLE_HOURS $PROJECT_ID $POSITION_TYPE_ID $EMPLOYEE_ID "$UUID"
      unset NAME
      unset START_DATE
      unset END_DATE
      unset BILL_RATE
      unset COST
      unset DAILY_BILLABLE_HOURS
      unset PROJECT_ID
      unset POSITION_TYPE_ID
      unset EMPLOYEE_ID
      unset UUID
      ;;
   --employee)
      log_debug "processing employee ---"
      process_params $@
      FIRST_NAME=$(echo $FIRST_NAME)
      LAST_NAME=$(echo $LAST_NAME)
      UUID=$(echo $UUID)
      log_debug "processing first name -> $FIRST_NAME"
      log_debug "processing last name -> $LAST_NAME"
      log_debug "processing email -> $EMAIL"
      log_debug "processing start_date -> $START_DATE"
      log_debug "processing hourly_cost -> $HOURLY_COST"
      log_debug "processing daily_billable_hours -> $DAILY_BILLABLE_HOURS"
      log_debug "processing utilization_target -> $UTILIZATION_TARGET"
      log_debug "processing employee_type_id -> $EMPLOYEE_TYPE_ID"
      log_debug "processing region_id -> $REGION_ID"
      log_debug "processing uuid -> $UUID"
      process_employee "$FIRST_NAME" "$LAST_NAME" "$EMAIL" $START_DATE $HOURLY_COST $DAILY_BILLABLE_HOURS $UTILIZATION_TARGET $EMPLOYEE_TYPE_ID $REGION_ID "$UUID"
      unset DAILY_BILLABLE_HOURS
      unset EMAIL
      unset EMPLOYEE_TYPE_ID
      unset FIRST_NAME
      unset HOURLY_COST
      unset LAST_NAME
      unset REGION_ID
      unset START_DATE
      unset UTILIZATION_TARGET
      unset UUID
      ;;
   --region)
      log_debug "processing region ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing region -> $NAME"
      log_debug "processing uuid -> $UUID"
      process_region "$NAME" "$UUID"
      unset NAME
      unset UUID
      ;;
   --project_fixed_bid)
      log_debug "processing project_fixed_bid ---"
      process_params $@
      NAME=$(echo $NAME)
      STATUS=$(echo $STATUS)
      UUID=$(echo $UUID)
      log_debug "processing project -> $NAME"
      log_debug "processing customer_id -> $CUSTOMER_ID"
      log_debug "processing region_id -> $REGION_ID"
      log_debug "processing status -> $STATUS"
      log_debug "processing amount -> $AMOUNT"
      log_debug "processing billing_type -> Fixed Bid"
      log_debug "processing uuid -> $UUID"
      process_project_fixed_bid "$NAME" $CUSTOMER_ID $REGION_ID "$STATUS" $AMOUNT "Fixed Bid" "$UUID"
      unset NAME
      unset CUSTOMER_ID
      unset REGION_ID
      unset STATUS
      unset AMOUNT
      unset UUID
      ;;
   --project_retainer)
      log_debug "processing project_retainer ---"
      process_params $@
      NAME=$(echo $NAME)
      STATUS=$(echo $STATUS)
      UUID=$(echo $UUID)
      log_debug "processing project -> $NAME"
      log_debug "processing customer_id -> $CUSTOMER_ID"
      log_debug "processing region_id -> $REGION_ID"
      log_debug "processing status -> $STATUS"
      log_debug "processing monthly_amount -> $MONTHLY_AMOUNT"
      log_debug "processing billing_type -> Retainer"
      log_debug "processing uuid -> $UUID"
      process_project_retainer "$NAME" $CUSTOMER_ID $REGION_ID "$STATUS" $MONTHLY_AMOUNT "Retainer" "$UUID"
      unset NAME
      unset CUSTOMER_ID
      unset REGION_ID
      unset STATUS
      unset MONTHLY_AMOUNT
      unset UUID
      ;;
   --project_time_materials)
      log_debug "processing project_time_materials ---"
      process_params $@
      NAME=$(echo $NAME)
      STATUS=$(echo $STATUS)
      UUID=$(echo $UUID)
      log_debug "processing project -> $NAME"
      log_debug "processing customer_id -> $CUSTOMER_ID"
      log_debug "processing region_id -> $REGION_ID"
      log_debug "processing status -> $STATUS"
      log_debug "processing billing_type -> Time and Materials"
      log_debug "processing uuid -> $UUID"
      process_project_time_materials "$NAME" $CUSTOMER_ID $REGION_ID "$STATUS" "Time and Materials" "$UUID"
      unset NAME
      unset CUSTOMER_ID
      unset REGION_ID
      unset STATUS
      unset UUID
      ;;
   --work_exception_type)
      log_debug "processing work_exception_type ---"
      process_params $@
      NAME=$(echo $NAME)
      UUID=$(echo $UUID)
      log_debug "processing work_exception_types -> $NAME"
      log_debug "processing uuid -> $UUID"
      process_work_exception_type "$NAME" "$UUID"
      unset NAME
      unset UUID
      ;;
   --work_exception)
      log_debug "processing work_exception ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      log_debug "processing work exception -> $DESCRIPTION"
      log_debug "processing date -> $DATE"
      log_debug "processing employee_id -> $EMPLOYEE_ID"
      log_debug "processing work_exception_type -> $WORK_EXCEPTION_TYPE_ID"
      log_debug "processing hours -> $HOURS"
      process_work_exception "$DESCRIPTION" $DATE $EMPLOYEE_ID $WORK_EXCEPTION_TYPE_ID $HOURS
      unset DESCRIPTION
      unset DATE
      unset EMPLOYEE_ID
      unset WORK_EXCEPTION_TYPE_ID
      unset HOURS
      ;;
   --holiday)
      log_debug "processing holiday ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      UUID=$(echo $UUID)
      log_debug "processing date -> $DATE"
      log_debug "processing name -> $DESCRIPTION"
      log_debug "processing hours -> $HOURS"
      log_debug "processing type -> $WORK_EXCEPTION_TYPE_ID"
      log_debug "processing uuid -> $UUID"
      process_holiday $DATE "$DESCRIPTION" $HOURS $WORK_EXCEPTION_TYPE_ID "$UUID"
      unset DATE
      unset DESCRIPTION
      unset HOURS
      unset WORK_EXCEPTION_TYPE_ID
      unset UUID
      ;;
   -*)
      # Unexpected option
      log_error "unexpected option"
      #exit 1
      ;;
   *)
      log_error "break"
      break
      ;;
   esac
}

process_data_dsl() {
if test -f "tenants/$TENANT/data.dsl"; then
   log_info "$TENANT exists... continuing!"
   cat "tenants/$TENANT/data.dsl" > /tmp/file1.tmp
   perl -pe 's/HEADER/`cat data_header.dsl`/ge' -i /tmp/file1.tmp
   perl -pe 's/LOGIN/`cat data_login.dsl`/ge' -i /tmp/file1.tmp
   awk 'NF' /tmp/file1.tmp > /tmp/file2.tmp

   envsubst < /tmp/file2.tmp > /tmp/file.tmp

   while IFS= read -r line; do
      if [[ $line != /--* ]]; then
         log_debug "-----------------------------------------------------------------------------------------"
         log_debug "incoming line from file : $line"
         process_input $line
      else
         log_debug "skipping $line"
      fi
   done <"/tmp/file.tmp"
else
   log_error "$TENANT does not exist... exiting!"
   exit 1
fi
}

process_version_dsl() {
   touch /tmp/file.tmp
   touch /tmp/file1.tmp
   touch /tmp/file2.tmp

    if test -f "tenants/version/data.dsl"; then
       log_info "VERSION file exists... continuing!"
       cat "tenants/version/data.dsl" > /tmp/file1.tmp
       awk 'NF' /tmp/file1.tmp > /tmp/file2.tmp

       envsubst < /tmp/file2.tmp > /tmp/file.tmp

       while IFS= read -r line; do
          if [[ $line != /--* ]]; then
             log_debug "-----------------------------------------------------------------------------------------"
             log_debug "incoming line from file : $line"
             process_input $line
          else
             log_debug "skipping $line"
          fi
       done <"/tmp/file.tmp"
    else
       log_error "VERSION file does not exist... exiting!"
       exit 1
    fi
}

echo "Do you want to update the application version? (enter Q to quit): [y/N]"
read update_version
update_version=${update_version:-N}

if [ $update_version = "N" ] || [ $update_version = "n" ]; then
    gather_ENV
    gather_HOST
    gather_TENANTS
    gather_DOMAIN
    gather_LOGGING
    process_data_dsl
else
    gather_ENV
    gather_HOST
    gather_VERSION
    gather_NOTES
    gather_LOGGING
    process_version_dsl
fi
