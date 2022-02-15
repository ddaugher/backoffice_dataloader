#!/bin/bash

source ./configs.sh
source ./functions.sh

ALL_ENVS=(LOCAL DEV STAGE PROD)
export ENV=''
export TENANT=BASE

ACCESS_TOKEN=''
export HOST=''
export DOMAIN=''
PROGRAM_NAME=$0
RENEWAL_TOKEN=''
CURL='/usr/bin/curl'

gather_HOST() {
   echo "--------------------------------------> $ENV"
   if [ "$ENV" == LOCAL ]; then
      export HOST="http://localhost:4000"
   elif [ "$ENV" == DEV ]; then
      export HOST="https://backoffice.gigalixirapp.com"
   elif [ "$ENV" == STAGE ]; then
      export HOST="https://backofficestaging.gigalixirapp.com"
   elif [ "$ENV" == PROD ]; then
      export HOST="https://backofficeprod.gigalixirapp.com"
   else
      export HOST="https://backoffice.gigalixirapp.com"
   fi
}

gather_DOMAIN() {
   export DOMAIN=$(echo "$TENANT.com")
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
   echo "Setting ENV -> $ENV"
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

   echo "Enter name of TENANT to apply (enter Q to quit): [1]"
   read tenant
   tenant=${tenant:-base}

   if [ $tenant = "Q" ] || [ $tenant = "q" ]; then
      exit 0
   fi

   export TENANT=$tenant
   echo $TENANT
   return 0
}

function usage() {
   clear
   echo "-----------------------------------------------------------------------------------------"
   echo "This script will create necessary default entries when creating a new tenant."
   echo ""
   echo "usage: $PROGRAM_NAME input_file"
   echo ""
   echo " --create_tenant --name [string]"
   echo " --customer --name [string] --is_active [true/false]"
   echo " --daily_expense_type --name [string]"
   echo " --delete_tenant --name [string]"
   echo " --employee --first_name [string] --last_name [string] --email [string] --start_date [yyyy-mm-dd] --hourly_cost [decimal] --daily_billable_hours [integer (1-8)] --utilization_target [decimal] --employee_type_id [id] --region_id [id]"
   echo " --employee_type --name [string] --is_employee [true/false] --is_utilized [true/false]"
   echo " --global_detail --name [string] --extended_fields [string]"
   echo " --holiday --date [yyyy-mm-dd] --description [string] --hours [integer (1-8)] --work_exception_type_id [id]"
   echo " --host --url [url]"
   echo " --login --username [string] --password [string]]"
   echo " --tenant_login"
   echo " --monthly_expense_type --name [string]"
   echo " --open_position --name [string] --start_date [yyyy-mm-dd] --end_date [yyyy-mm-dd] --bill_rate [decimal] --cost [decimal] --daily_billable_hours [integer (1-8)] --project_id [id] --position_type_id [id]"
   echo " --position_monthly_expense --month [integer] --year [integer] --cost [decimal] --description [string] --position_id [id] --monthly_expense_type_id [id]"
   echo " --position_daily_expense --cost [decimal] --description [string] --position_id [id] --monthly_expense_type_id [id]"
   echo " --position_type --name [string]"
   echo " --position_with_employee --name [string] --start_date [yyyy-mm-dd] --end_date [yyyy-mm-dd] --bill_rate [decimal] --cost [decimal] --daily_billable_hours [integer (1-8)] --project_id [id] --position_type_id [id] --employee_id [id]"
   echo " --project_time_material --name [string] --customer_id [id] --region_id [id] --status [string]"
   echo " --project_retainer --name [string] --customer_id [id] --region_id [id] --status [string] --monthly_amount [decimal]"
   echo " --project_fixed_bid --name [string] --customer_id [id] --region_id [id] --status [string] --amount [decimal]"
   echo " --region --name [string]"
   echo " --registration --email [string] --pass [string] --api_access [true/false] --role [string (user/admin)] --self_service_storage [string]"
   echo " --release_version --version [string] --notes [string]"
   echo " --renew"
   echo " --tenant_mapping --domain [string] --tenant [string]"
   echo " --delete_tenant_mapping --tenant [string]"
   echo " --delete_tenant_mapping --tenant [string]"
   echo " --work_exception --description [string] --date [yyyy-mm-dd] --employee_id [id] --work_exception_type_id [id] --hours [integer (1-8)]"
   echo " --work_exception_type --name [string]"
   echo "-----------------------------------------------------------------------------------------"

   exit 1
}

# if less than one argument supplied, display usage
# if [ $# -lt 1 ]; then
#    usage
#    exit 1
# fi

# check whether user supplied -h or --help . If yes display usage
# if [[ ($1 == "--help") || $1 == "-h" ]]; then
#    usage
#    exit 0
# fi

function process_params() {
   shift
   while :; do
      echo $1
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
            VERSION="$VERSION $1"
            shift
         done
         ;;
      --notes)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            NOTES="$NOTES $1"
            shift
         done
         ;;
      --name)
         shift
         while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
            NAME="$NAME $1"
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
   echo "input line : $1"
   case "$1" in
   --host)
      echo "processing host -> $HOST"
      ;;
   --tenant_login)
      echo "processing username -> $TENANT_USERNAME"
      echo "processing password -> $TENANT_PASSWORD"
      create_session $TENANT_USERNAME $TENANT_PASSWORD
      ;;
   --login)
      process_params $@
      echo "processing username -> $USERNAME"
      echo "processing password -> $PASSWORD"
      create_session $USERNAME $PASSWORD
      ;;
   --renew)
      shift
      echo "processing renewal token -> $RENEWAL_TOKEN"
      process_renewal $RENEWAL_TOKEN
      ;;
   --registration)
      process_params $@
      echo "processing email -> $EMAIL"
      echo "processing password -> $PASS"
      echo "processing api_access -> $API_ACCESS"
      echo "processing role -> $ROLE"
      echo "processing self service storage -> $SELF_SERVICE_STORAGE"
      SELF_SERVICE_STORAGE=$(echo $SELF_SERVICE_STORAGE)
      process_registration $EMAIL $PASS $API_ACCESS $ROLE "$SELF_SERVICE_STORAGE"
      unset EMAIL
      unset PASS
      unset API_ACCESS
      unset ROLE
      unset SELF_SERVICE_STORAGE
      ;;
   --create_tenant)
      process_params $@
      NAME=$(echo $NAME)
      echo "processing tenant -> $NAME"
      process_create_tenant $NAME
      unset NAME
      ;;
   --delete_tenant)
      process_params $@
      NAME=$(echo $NAME)
      echo "processing tenant -> $NAME"
      process_delete_tenant $NAME
      unset NAME
      ;;
   --global_detail)
      process_params $@
      echo "processing name -> $NAME"
      echo "processing extended_fields -> $EXTENDED_FIELDS"
      process_global_detail $NAME "$EXTENDED_FIELDS"
      unset NAME
      unset EXTENDED_FIELDS
      ;;
   --tenant_mapping)
      process_params $@
      echo "processing domain -> $DOMAIN"
      echo "processing tenant -> $TENANT"
      process_tenant_mapping $DOMAIN $TENANT
      unset DOMAIN
      unset TENANT
      ;;
   --delete_tenant_mapping)
      process_params $@
      echo "processing tenant -> $TENANT"
      process_delete_tenant_mapping $TENANT
      unset TENANT
      ;;
   --region)
      process_params $@
      NAME=$(echo $NAME)
      echo "processing region -> $NAME"
      process_region $NAME
      unset NAME
      ;;
   --monthly_expense_type)
      process_params $@
      NAME=$(echo $NAME)
      echo "processing monthly_expense_type -> $NAME"
      process_monthly_expense_type $NAME
      unset NAME
      ;;
   --daily_expense_type)
      process_params $@
      NAME=$(echo $NAME)
      echo "processing daily_expense_types -> $NAME"
      process_daily_expense_type $NAME
      unset NAME
      ;;
   --position_type)
      process_params $@
      NAME=$(echo $NAME)
      echo "processing position_types -> $NAME"
      process_position_type "$NAME"
      unset NAME
      ;;
   --employee_type)
      process_params $@
      NAME=$(echo $NAME)
      echo "processing employee type -> $NAME"
      echo "processing is_employee -> $IS_EMPLOYEE"
      echo "processing is_utilized -> $IS_UTILIZED"
      process_employee_type "$NAME" $IS_EMPLOYEE $IS_UTILIZED
      unset NAME
      unset IS_EMPLOYEE
      unset IS_UTILIZED
      ;;
   --customer)
      echo "processing customers ---"
      process_params $@
      NAME=$(echo $NAME)
      echo "processing customer -> $NAME"
      echo "processing is_active -> $IS_ACTIVE"
      process_customer "$NAME" $IS_ACTIVE
      unset NAME
      unset IS_ACTIVE
      ;;
   --sleep)
      echo "processing sleeping ---"
      sleep 5
      ;;
   --position_monthly_expense)
      echo "processing position monthly expenses ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      echo "processing position -> $DESCRIPTION"
      echo "processing month -> $MONTH"
      echo "processing year -> $YEAR"
      echo "processing cost -> $COST"
      echo "processing position_id -> $POSITION_ID"
      echo "processing monthly_expense_type_id -> $MONTHLY_EXPENSE_TYPE_ID"
      process_position_monthly_expense $MONTH $YEAR $COST "$DESCRIPTION" $POSITION_ID $MONTHLY_EXPENSE_TYPE_ID
      unset DESCRIPTION
      unset MONTH
      unset YEAR
      unset COST
      unset POSITION_ID
      unset MONTHLY_EXPENSE_TYPE_ID
      ;;
   --position_daily_expense)
      echo "processing position daily expenses ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      echo "processing position -> $DESCRIPTION"
      echo "processing cost -> $COST"
      echo "processing position_id -> $POSITION_ID"
      echo "processing monthly_expense_type_id -> $MONTHLY_EXPENSE_TYPE_ID"
      process_position_daily_expense $COST "$DESCRIPTION" $POSITION_ID $MONTHLY_EXPENSE_TYPE_ID
      unset DESCRIPTION
      unset COST
      unset POSITION_ID
      unset MONTHLY_EXPENSE_TYPE_ID
      ;;
   --position_with_employee)
      echo "processing positions ---"
      process_params $@
      NAME=$(echo $NAME)
      echo "processing position -> $NAME"
      echo "processing start_date -> $START_DATE"
      echo "processing end_date -> $END_DATE"
      echo "processing bill_rate -> $BILL_RATE"
      echo "processing cost -> $COST"
      echo "processing daily_billable_hours -> $DAILY_BILLABLE_HOURS"
      echo "processing project_id -> $PROJECT_ID"
      echo "processing position_type_id -> $POSITION_TYPE_ID"
      echo "processing employee_id -> $EMPLOYEE_ID"
      process_position_with_employee "$NAME" $START_DATE $END_DATE $BILL_RATE $COST $DAILY_BILLABLE_HOURS $PROJECT_ID $POSITION_TYPE_ID $EMPLOYEE_ID
      unset NAME
      unset START_DATE
      unset END_DATE
      unset BILL_RATE
      unset COST
      unset DAILY_BILLABLE_HOURS
      unset PROJECT_ID
      unset POSITION_TYPE_ID
      unset EMPLOYEE_ID
      ;;
   --open_position)
      echo "processing positions ---"
      process_params $@
      NAME=$(echo $NAME)
      echo "processing position -> $NAME"
      echo "processing start_date -> $START_DATE"
      echo "processing end_date -> $END_DATE"
      echo "processing bill_rate -> $BILL_RATE"
      echo "processing cost -> $COST"
      echo "processing daily_billable_hours -> $DAILY_BILLABLE_HOURS"
      echo "processing project_id -> $PROJECT_ID"
      echo "processing position_type_id -> $POSITION_TYPE_ID"
      process_open_position "$NAME" $START_DATE $END_DATE $BILL_RATE $COST $DAILY_BILLABLE_HOURS $PROJECT_ID $POSITION_TYPE_ID
      unset NAME
      unset START_DATE
      unset END_DATE
      unset BILL_RATE
      unset COST
      unset DAILY_BILLABLE_HOURS
      unset PROJECT_ID
      unset POSITION_TYPE_ID
      ;;
   --employee)
      echo "processing employees ---"
      process_params $@
      FIRST_NAME=$(echo $FIRST_NAME)
      LAST_NAME=$(echo $LAST_NAME)
      echo "processing employee -> $FIRST_NAME $LAST_NAME"
      echo "processing email -> $EMAIL"
      echo "processing start_date -> $START_DATE"
      echo "processing hourly_cost -> $HOURLY_COST"
      echo "processing daily_billable_hours -> $DAILY_BILLABLE_HOURS"
      echo "processing utilization_target -> $UTILIZATION_TARGET"
      echo "processing employee_type_id -> $EMPLOYEE_TYPE_ID"
      echo "processing region_id -> $REGION_ID"
      process_employee "$FIRST_NAME" "$LAST_NAME" $EMAIL $START_DATE $HOURLY_COST $DAILY_BILLABLE_HOURS $UTILIZATION_TARGET $EMPLOYEE_TYPE_ID $REGION_ID
      unset DAILY_BILLABLE_HOURS
      unset EMAIL
      unset EMPLOYEE_TYPE_ID
      unset FIRST_NAME
      unset HOURLY_COST
      unset LAST_NAME
      unset REGION_ID
      unset START_DATE
      unset UTILIZATION_TARGET
      ;;
   --project_fixed_bid)
      echo "processing projects ---"
      process_params $@
      NAME=$(echo $NAME)
      STATUS=$(echo $STATUS)
      echo "processing project -> $NAME"
      echo "processing customer_id -> $CUSTOMER_ID"
      echo "processing region_id -> $REGION_ID"
      echo "processing status -> $STATUS"
      echo "processing amount -> $AMOUNT"
      echo "processing billing_type -> Fixed Bid"
      process_project_fixed_bid "$NAME" $CUSTOMER_ID $REGION_ID "$STATUS" $AMOUNT "Fixed Bid"
      unset AMOUNT
      unset CUSTOMER_ID
      unset NAME
      unset REGION_ID
      unset STATUS
      ;;
   --project_retainer)
      echo "processing projects ---"
      process_params $@
      NAME=$(echo $NAME)
      STATUS=$(echo $STATUS)
      echo "processing project -> $NAME"
      echo "processing customer_id -> $CUSTOMER_ID"
      echo "processing region_id -> $REGION_ID"
      echo "processing status -> $STATUS"
      echo "processing monthly_amount -> $MONTHLY_AMOUNT"
      echo "processing billing_type -> Retainer"
      process_project_retainer "$NAME" $CUSTOMER_ID $REGION_ID "$STATUS" $MONTHLY_AMOUNT "Retainer"
      unset CUSTOMER_ID
      unset MONTHLY_AMOUNT
      unset NAME
      unset REGION_ID
      unset STATUS
      ;;
   --project_time_materials)
      echo "processing projects ---"
      process_params $@
      NAME=$(echo $NAME)
      STATUS=$(echo $STATUS)
      echo "processing project -> $NAME"
      echo "processing customer_id -> $CUSTOMER_ID"
      echo "processing region_id -> $REGION_ID"
      echo "processing status -> $STATUS"
      echo "processing billing_type -> Time and Materials"
      process_project_time_materials "$NAME" $CUSTOMER_ID $REGION_ID "$STATUS" "Time and Materials"
      unset CUSTOMER_ID
      unset NAME
      unset REGION_ID
      unset STATUS
      ;;
   --work_exception_type)
      echo "processing work execption types ---"
      process_params $@
      NAME=$(echo $NAME)
      echo "processing work_exception_types -> $NAME"
      process_work_exception_type "$NAME"
      unset NAME
      ;;
   --work_exception)
      echo "processing work exception ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      echo "processing work exception -> $DESCRIPTION"
      echo "processing date -> $DATE"
      echo "processing employee_id -> $EMPLOYEE_ID"
      echo "processing work_exception_type -> $WORK_EXCEPTION_TYPE_ID"
      echo "processing hours -> $HOURS"
      process_work_exception "$DESCRIPTION" $DATE $EMPLOYEE_ID $WORK_EXCEPTION_TYPE_ID $HOURS
      unset DESCRIPTION
      unset DATE
      unset EMPLOYEE_ID
      unset WORK_EXCEPTION_TYPE_ID
      unset HOURS
      ;;
   --release_version)
      echo "processing release versions ---"
      process_params $@
      VERSION=$(echo $VERSION)
      NOTES=$(echo $NOTES)
      echo "processing release_versions -> $VERSION"
      echo "processing notes -> $NOTES"
      process_release_version $VERSION $NOTES
      ;;
   --holiday)
      echo "processing holidays ---"
      process_params $@
      DESCRIPTION=$(echo $DESCRIPTION)
      echo "processing date -> $DATE"
      echo "processing name -> $DESCRIPTION"
      echo "processing hours -> $HOURS"
      echo "processing type -> $WORK_EXCEPTION_TYPE_ID"
      process_holiday $DATE "$DESCRIPTION" $HOURS $WORK_EXCEPTION_TYPE_ID
      unset DATE
      unset DESCRIPTION
      unset HOURS
      unset WORK_EXCEPTION_TYPE_ID
      ;;
   -*)
      # Unexpected option
      echo "unexpected option"
      #exit 1
      ;;
   *)
      echo "break"
      break
      ;;
   esac
}

gather_ENV
gather_HOST
gather_TENANTS
gather_DOMAIN

if test -f "tenants/$TENANT/data.dsl"; then
   echo "$TENANT exists... continuing!"
   envsubst <"tenants/$TENANT/data.dsl" >/tmp/file.tmp

   while IFS= read -r line; do
      if [[ $line != /--* ]]; then
         echo "-----------------------------------------------------------------------------------------"
         echo "incoming line from file : $line"
         process_input $line
      else
         echo "skipping $line"
      fi
   done <"/tmp/file.tmp"
else
   echo "$TENANT does not exist... exiting!"
   exit 1
fi
