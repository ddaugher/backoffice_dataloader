#!/bin/bash

function jsonValue {
    KEY=$1
    num=$2
    awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

function create_session() {
   URL="$HOST/api/v1/session"
   IFS=' '

   log_info "--- Creating session -> $1 $2"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --data-raw "{ \"user\": { \"email\": \"$1\", \"password\": \"$2\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      ACCESS_TOKEN=$(echo $response | jsonValue access_token)
      RENEWAL_TOKEN=$(echo $response | jsonValue renewal_token)

      log_info "----- ACTIVE SESSION ----- $http_code"
      log_info "ACCESS_TOKEN -> $ACCESS_TOKEN"
      log_info "RENEWAL_TOKEN -> $RENEWAL_TOKEN"
   fi
}

function process_create_tenant() {
   URL="$HOST/api/v1/tenants"
   IFS=' '

   log_info "--- Creating tenant -> $1"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"name\": \"$1\" }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      log_info "----- TENANT CREATED ----- $http_code"
   fi
}

function process_delete_tenant() {
   URL="$HOST/api/v1/tenants/$1"
   IFS=' '

   log_info "--- Deleting tenant -> $1"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location -X "DELETE" $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_info "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      log_info "----- TENANT DELETED ----- $http_code"
   fi
}

function process_tenant_mapping() {
   URL="$HOST/api/v1/tenant_mappings"
   IFS=' '

   log_debug $DOMAIN

   log_info "--- Creating tenant mapping -> $1 $2"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"tenant_mapping\": { \"domain\": \"$1\", \"tenant\": \"$2\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_info "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      log_info "----- TENANT MAPPING CREATED ----- $http_code"
   fi
}

function process_delete_tenant_mapping() {
   URL="$HOST/api/v1/tenant_mappings?tenant=$1"
   IFS=' '

   log_debug $DOMAIN

   log_info "--- Deleting tenant mapping -> $1"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request GET $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN")

   http_code=$(tail -n1 <<<"$response")
   log_debug $http_code

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_info "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE"
   else
      ID=$(echo $response | jsonValue id)
      log_debug "id -> $ID"
   fi

   URL="$HOST/api/v1/tenant_mappings/$ID"
   IFS=' '
   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request DELETE $URL \
      --header "Authorization: $ACCESS_TOKEN")

   http_code=$(tail -n1 <<<"$response")
   log_debug $http_code

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_info "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_error "Unable to continue : $http_code, $MESSAGE"
   else
      log_info "----- TENANT MAPPING DELETED ----- $http_code"
   fi
}

function process_global_detail() {
   URL="$HOST/api/v1/global_details"
   IFS=' '

   log_info "--- Creating global detail-> $1 $2"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "$(echo { \"global_detail\": { \"name\": \"$1\", \"extended_fields\": $2 } })")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      log_info "----- GLOBAL DETAIL CREATED ----- $http_code"
   fi
}

function process_registration() {
   URL="$HOST/api/v1/registration"
   IFS=' '

   log_debug "--- Inserting user -> $1 $2 $3 $4 $5"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"user\": { \"email\": \"$1\", \"password\": \"$2\", \"password_confirmation\": \"$2\", \"api_access\": \"$3\", \"role\": \"$4\", \"self_service_storage\": \"$5\"} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_info "User already exists... continuing! : $http_code, $MESSAGE", $response
   else
      log_info "----- USER CREATED ----- $http_code"
   fi
}

function process_renewal() {
   URL="$HOST/api/v1/session/renew"
   IFS=' '

   log_info "--- renewing token -> $RENEWAL_TOKEN"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $RENEWAL_TOKEN")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      ACCESS_TOKEN=$(echo $response | jsonValue access_token)
      RENEWAL_TOKEN=$(echo $response | jsonValue renewal_token)

      log_info "----- ACTIVE RENEWAL ----- $http_code"
      log_info "ACCESS_TOKEN -> $ACCESS_TOKEN"
      log_info "RENEWAL_TOKEN -> $RENEWAL_TOKEN"
   fi
}

function process_work_exception() {
   URL="$HOST/api/v1/work_exceptions"
   IFS=' '

   log_debug $@

   log_debug "--- Inserting work exception -> $1 $2 $3 $4 $5"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"work_exception\": { \"description\": \"$1\", \"date\": \"$2\", \"employee_id\": $3, \"work_exception_type_id\": $4, \"hours\": $5} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      log_info "----- WORK EXCEPTION CREATED ----- $http_code"
   fi
}

function process_release_version() {
   URL="$HOST/api/v1/release_versions"
   IFS=' '

   log_debug "--- Inserting Release Version -> $1 $2"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"release_version\": { \"version\": \"$1\", \"notes\": \"$2\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      log_info "----- RELEASE VERSION CREATED ----- $http_code"
   fi
}

function process_position_monthly_expense() {
   URL="$HOST/api/v1/monthly_expenses/position"
   IFS=' '

   log_debug "--- Inserting position_monthly_expense -> $1 $2 $3 $4 $5 $6"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position_monthly_expense\": { \"month\": $1, \"year\": $2, \"cost\": $3, \"description\": \"$4\", \"position_id\": $5, \"type_id\": $6 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- POSITION MONTHLY EXPENSE CREATED ----- $http_code"
   fi
}

function process_position_daily_expense() {
   URL="$HOST/api/v1/daily_expenses/position"
   IFS=' '

   log_debug "--- Inserting position_daily_expense -> $1 $2 $3 $4"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position_daily_expense\": { \"cost\": $1, \"description\": \"$2\", \"position_id\": $3, \"type_id\": $4 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      log_warn "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      log_info "----- POSITION DAILY EXPENSE CREATED ----- $http_code"
   fi
}

function process_project_time_materials() {
   URL="$HOST/api/v1/projects"
   IFS=' '

   CUSTOMER_ID=$(kvget $2)
   REGION_ID=$(kvget $3)
   log_debug "--- Inserting project -> $1 $CUSTOMER_ID $REGION_ID $4 $5 $6"

   response=$($CURL --silent --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"project\": { \"name\": \"$1\", \"customer_id\": $CUSTOMER_ID, \"region_id\": $REGION_ID, \"status\": \"$4\", \"billing_type\": \"$5\"} }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.project.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- TIME MATERIALS PROJECT CREATED $ID ----- $SUCCESS"
      kvset $6 $ID
   fi
}

function process_project_retainer() {
   URL="$HOST/api/v1/projects"
   IFS=' '

   CUSTOMER_ID=$(kvget $2)
   REGION_ID=$(kvget $3)
   log_debug "--- Inserting project -> $1 $CUSTOMER_ID $REGION_ID $4 $5 $6 $7"

   response=$($CURL --silent --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"project\": { \"name\": \"$1\", \"customer_id\": $CUSTOMER_ID, \"region_id\": $REGION_ID, \"status\": \"$4\", \"amount\": \"$5\", \"billing_type\": \"$6\"} }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.project.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- RETAINER PROJECT CREATED $ID ----- $SUCCESS"
      kvset $7 $ID
   fi
}

function process_holiday() {
   URL="$HOST/api/v1/holidays"
   IFS=' '

   WORK_EXCEPTION_TYPE_ID=$(kvget $4)

   log_debug "--- Inserting holiday -> $1 $2 $3 $WORK_EXCEPTION_TYPE_ID $5"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"holiday\": { \"date\": \"$1\", \"description\": \"$2\", \"hours\": $3, \"work_exception_type_id\": $WORK_EXCEPTION_TYPE_ID } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.holiday.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- HOLIDAY CREATED $ID ----- $SUCCESS"
      kvset $5 $ID
   fi
}

function process_project_fixed_bid() {
   URL="$HOST/api/v1/projects"
   IFS=' '

   CUSTOMER_ID=$(kvget $2)
   REGION_ID=$(kvget $3)
   log_debug "--- Inserting project -> $1 $CUSTOMER_ID $REGION_ID $4 $5 $6 $7"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"project\": { \"name\": \"$1\", \"customer_id\": $CUSTOMER_ID, \"region_id\": $REGION_ID, \"status\": \"$4\", \"amount\": \"$5\", \"billing_type\": \"$6\"} }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.project.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- FIXED BID PROJECT CREATED $ID ----- $SUCCESS"
      kvset $7 $ID
   fi
}

function process_region() {
   URL="$HOST/api/v1/regions"
   IFS=' '

   log_debug "--- Inserting region -> $1 $2"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"region\": { \"name\": \"$1\" } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.region.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- REGION CREATED $ID ----- $SUCCESS"
      kvset $2 $ID
   fi
}

function process_work_exception_type() {
   URL="$HOST/api/v1/work_exception_types"
   IFS=' '

   log_debug "--- Inserting Work Exception Type -> $1 $2"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"work_exception_type\": { \"name\": \"$1\" } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.work_exception_type.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- WORK EXCEPTION TYPE CREATED $ID ----- $SUCCESS"
      kvset $2 $ID
   fi
}

function process_position_type() {
   URL="$HOST/api/v1/position_types"
   IFS=' '

   log_debug "--- Inserting Position Type -> $1 $2"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position_type\": { \"name\": \"$1\" } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.position_type.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- POSITION TYPE CREATED $ID ----- $SUCCESS"
      kvset $2 $ID
   fi
}

function process_open_position() {
   URL="$HOST/api/v1/positions"
   IFS=' '

   PROJECT_ID=$(kvget $7)
   POSITION_TYPE_ID=$(kvget $8)

   log_debug "--- Inserting position -> $1 $2 $3 $4 $5 $6 $PROJECT_ID $POSITION_TYPE_ID $9"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position\": { \"name\": \"$1\", \"start_date\": \"$2\", \"end_date\": \"$3\", \"bill_rate\": $4, \"cost\": $5, \"daily_billable_hours\": $6, \"project_id\": $PROJECT_ID, \"position_type_id\": $POSITION_TYPE_ID } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.position.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- POSITION CREATED $ID ----- $SUCCESS"
      kvset $9 $ID
   fi
}

function process_daily_expense_type() {
   URL="$HOST/api/v1/daily_expense_types"
   IFS=' '

   log_debug "--- Inserting daily_expense_type -> $1 $2"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"daily_expense_type\": { \"name\": \"$1\" } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.daily_expense_type.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- DAILY EXPENSE TYPE CREATED $ID ----- $SUCCESS"
      kvset $2 $ID
   fi
}

function process_monthly_expense_type() {
   URL="$HOST/api/v1/monthly_expense_types"
   IFS=' '

   log_debug "--- Inserting monthly expense type -> $1 $2"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"monthly_expense_type\": { \"name\": \"$1\" } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.monthly_expense_type.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- MONTHLY EXPENSE TYPE CREATED $ID ----- $SUCCESS"
      kvset $2 $ID
   fi
}

function process_employee_type() {
   URL="$HOST/api/v1/employee_types"
   IFS=' '

   log_debug "--- Inserting Employee Type -> $1 $2 $3 $4"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"employee_type\": { \"name\": \"$1\", \"is_employee\": $2, \"is_utilized\": $3 } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.employee_type.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- EMPLOYEE TYPE CREATED $ID ----- $SUCCESS"
      kvset $4 $ID
   fi
}

function process_position_with_employee() {
   URL="$HOST/api/v1/positions"
   IFS=' '

   PROJECT_ID=$(kvget $7)
   POSITION_TYPE_ID=$(kvget $8)
   EMPLOYEE_ID=$(kvget $9)

   log_debug "--- Inserting position -> $1 $2 $3 $4 $5 $6 $PROJECT_ID $POSITION_TYPE_ID $EMPLOYEE_ID ${10}"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position\": { \"name\": \"$1\", \"start_date\": \"$2\", \"end_date\": \"$3\", \"bill_rate\": $4, \"cost\": $5, \"daily_billable_hours\": $6, \"project_id\": $PROJECT_ID, \"position_type_id\": $POSITION_TYPE_ID, \"employee_id\": $EMPLOYEE_ID } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.position.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- POSITION CREATED $ID ----- $SUCCESS"
      kvset ${10} $ID
   fi
}

function process_customer() {
   URL="$HOST/api/v1/customers"
   IFS=' '

   log_debug "--- Inserting Customer -> $1 $2 $3"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"customer\": { \"name\": \"$1\", \"is_active\": $2 } }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.customer.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- CUSTOMER CREATED $ID ----- $SUCCESS"
      kvset $3 $ID
   fi
}

function process_employee() {

   URL="$HOST/api/v1/employees"
   IFS=' '

   log_debug "--------------------------------- ${10}"

   EMPLOYEE_TYPE_ID=$(kvget $8)
   REGION_ID=$(kvget $9)

   log_debug "--- Inserting employee -> $1 $2 $3 $4 $5 $6 $7 $EMPLOYEE_TYPE_ID $REGION_ID ${10}"

   response=$($CURL --silent --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"employee\": { \"first_name\": \"$1\", \"last_name\": \"$2\", \"email\": \"$3\", \"start_date\": \"$4\", \"hourly_cost\": \"$5\", \"daily_billable_hours\": \"$6\", \"utilization_target\": \"$7\", \"employee_type_id\": $EMPLOYEE_TYPE_ID, \"region_id\": $REGION_ID} }")

   SUCCESS=$(echo $response | jq ."success")
   MESSAGE=$(echo $response | jq ."message")
   ID=$(echo $response | jq ."data.employee.id")

   if [[ $SUCCESS != true ]]; then
      log_warn "Unable to continue : $SUCCESS, $MESSAGE", $response
      exit 1;
   else
      log_info "----- EMPLOYEE CREATED $ID ----- $SUCCESS"
      kvset ${10} $ID
   fi
}
