#!/bin/bash

function jsonValue {
    KEY=$1
    num=$2
    awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$KEY'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p
}

function create_session() {
   URL="$HOST/api/v1/session"
   IFS=' '

   echo "--- Creating session -> $1 $2"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --data-raw "{ \"user\": { \"email\": \"$1\", \"password\": \"$2\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      ACCESS_TOKEN=$(echo $response | jsonValue access_token)
      RENEWAL_TOKEN=$(echo $response | jsonValue renewal_token)

      echo "----- ACTIVE SESSION ----- $http_code"
      echo "ACCESS_TOKEN -> $ACCESS_TOKEN"
      echo "RENEWAL_TOKEN -> $RENEWAL_TOKEN"
   fi
}

function process_create_tenant() {
   URL="$HOST/api/v1/tenants"
   IFS=' '

   echo "--- Creating tenant -> $1"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"name\": \"$1\" }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      echo "----- TENANT CREATED ----- $http_code"
   fi
}

function process_delete_tenant() {
   URL="$HOST/api/v1/tenants/$1"
   IFS=' '

   echo "--- Deleting tenant -> $1"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location -X "DELETE" $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      echo "----- TENANT DELETED ----- $http_code"
   fi
}

function process_tenant_mapping() {
   URL="$HOST/api/v1/tenant_mappings"
   IFS=' '

   echo $DOMAIN

   echo "--- Creating tenant mapping -> $1 $2"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"tenant_mapping\": { \"domain\": \"$1\", \"tenant\": \"$2\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      echo "----- TENANT MAPPING CREATED ----- $http_code"
   fi
}

function process_delete_tenant_mapping() {
   URL="$HOST/api/v1/tenant_mappings?tenant=$1"
   IFS=' '

   echo $DOMAIN

   echo "--- Deleting tenant mapping -> $1"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request GET $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN")

   http_code=$(tail -n1 <<<"$response")
   echo $http_code

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE"
   else
      ID=$(echo $response | jsonValue id)
      echo "id -> $ID"
   fi

   URL="$HOST/api/v1/tenant_mappings/$ID"
   IFS=' '
   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request DELETE $URL \
      --header "Authorization: $ACCESS_TOKEN")

   http_code=$(tail -n1 <<<"$response")
   echo $http_code

   if [[ "$http_code" -eq 422 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "continuing : $http_code, $MESSAGE"
   elif [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE"
   else
      echo "----- TENANT MAPPING DELETED ----- $http_code"
   fi
}

function process_global_detail() {
   URL="$HOST/api/v1/global_details"
   IFS=' '

   echo "--- Creating global detail-> $1 $2"

   response=$($CURL -i -s --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "$(echo { \"global_detail\": { \"name\": \"$1\", \"extended_fields\": $2 } })")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE"
      exit 1;
   else
      echo "----- GLOBAL DETAIL CREATED ----- $http_code"
   fi
}

function process_registration() {
   URL="$HOST/api/v1/registration"
   IFS=' '

   echo "--- Inserting user -> $1 $2 $3 $4 $5"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"user\": { \"email\": \"$1\", \"password\": \"$2\", \"password_confirmation\": \"$2\", \"api_access\": \"$3\", \"role\": \"$4\", \"self_service_storage\": \"$5\"} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- USER CREATED ----- $http_code"
   fi
}

function process_renewal() {
   URL="$HOST/api/v1/session/renew"
   IFS=' '

   echo "--- renewing token -> $RENEWAL_TOKEN"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $RENEWAL_TOKEN")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 200 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      ACCESS_TOKEN=$(echo $response | jsonValue access_token)
      RENEWAL_TOKEN=$(echo $response | jsonValue renewal_token)

      echo "----- ACTIVE RENEWAL ----- $http_code"
      echo "ACCESS_TOKEN -> $ACCESS_TOKEN"
      echo "RENEWAL_TOKEN -> $RENEWAL_TOKEN"
   fi
}

function process_region() {
   URL="$HOST/api/v1/regions"
   IFS=' '

   echo "--- Inserting region -> $1"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"region\": { \"name\": \"$1\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- REGION CREATED ----- $http_code"
   fi
}

function process_monthly_expense_type() {
   URL="$HOST/api/v1/monthly_expense_types"
   IFS=' '

   echo "--- Inserting monthly expense type -> $1"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"monthly_expense_type\": { \"name\": \"$1\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- MONTHLY EXPENSE TYPE CREATED ----- $http_code"
   fi
}

function process_daily_expense_type() {
   URL="$HOST/api/v1/daily_expense_types"
   IFS=' '

   echo "--- Inserting daily_expense_type -> $1"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"daily_expense_type\": { \"name\": \"$1\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- DAILY EXPENSE TYPE CREATED ----- $http_code"
   fi
}

function process_position_type() {
   URL="$HOST/api/v1/position_types"
   IFS=' '

   echo "--- Inserting Position Type -> $1"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position_type\": { \"name\": \"$1\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- POSITION TYPE CREATED ----- $http_code"
   fi
}

function process_employee_type() {
   URL="$HOST/api/v1/employee_types"
   IFS=' '

   echo "--- Inserting Employee Type -> $1 $2 $3"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"employee_type\": { \"name\": \"$1\", \"is_employee\": $2, \"is_utilized\": $3 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- EMPLOYEE TYPE CREATED ----- $http_code"
   fi
}

function process_employee() {

   URL="$HOST/api/v1/employees"
   IFS=' '

   echo "--- Inserting employee -> $1 $2 $3 $4 $5 $6 $7 $8 $9"

   response=$($CURL -v -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"employee\": { \"first_name\": \"$1\", \"last_name\": \"$2\", \"email\": \"$3\", \"start_date\": \"$4\", \"hourly_cost\": \"$5\", \"daily_billable_hours\": \"$6\", \"utilization_target\": \"$7\", \"employee_type_id\": $8, \"region_id\": $9} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- EMPLOYEE CREATED ----- $http_code"
   fi
}

function process_customer() {
   URL="$HOST/api/v1/customers"
   IFS=' '

   echo "--- Inserting Customer -> $1 $2"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"customer\": { \"name\": \"$1\", \"is_active\": $2 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- CUSTOMER CREATED ----- $http_code"
   fi
}

function process_work_exception_type() {
   URL="$HOST/api/v1/work_exception_types"
   IFS=' '

   echo "--- Inserting Work Exception Type -> $1"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"work_exception_type\": { \"name\": \"$1\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- WORK EXCEPTION TYPE CREATED ----- $http_code"
   fi
}

function process_work_exception() {
   URL="$HOST/api/v1/work_exceptions"
   IFS=' '

   echo $@

   echo "--- Inserting work exception -> $1 $2 $3 $4 $5"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"work_exception\": { \"description\": \"$1\", \"date\": \"$2\", \"employee_id\": $3, \"work_exception_type_id\": $4, \"hours\": $5} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- WORK EXCEPTION CREATED ----- $http_code"
   fi
}

function process_release_version() {
   URL="$HOST/api/v1/release_versions"
   IFS=' '

   echo "--- Inserting Release Version -> $1 $2"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"release_version\": { \"version\": \"$1\", \"notes\": \"$2\" } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- RELEASE VERSION CREATED ----- $http_code"
   fi
}

function process_holiday() {
   URL="$HOST/api/v1/holidays"
   IFS=' '

   echo "--- Inserting holiday -> $1 $2 $3 $4"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"holiday\": { \"date\": \"$1\", \"description\": \"$2\", \"hours\": $3, \"work_exception_type_id\": $4 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- HOLIDAY CREATED ----- $http_code"
   fi
}

function process_position_with_employee() {
   URL="$HOST/api/v1/positions"
   IFS=' '

   echo "--- Inserting position -> $1 $2 $3 $4 $5 $6 $7 $8 $9"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position\": { \"name\": \"$1\", \"start_date\": \"$2\", \"end_date\": \"$3\", \"bill_rate\": $4, \"cost\": $5, \"daily_billable_hours\": $6, \"project_id\": $7, \"position_type_id\": $8, \"employee_id\": $9 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- POSITION CREATED ----- $http_code"
   fi
}

function process_open_position() {
   URL="$HOST/api/v1/positions"
   IFS=' '

   echo "--- Inserting position -> $1 $2 $3 $4 $5 $6 $7 $8"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position\": { \"name\": \"$1\", \"start_date\": \"$2\", \"end_date\": \"$3\", \"bill_rate\": $4, \"cost\": $5, \"daily_billable_hours\": $6, \"project_id\": $7, \"position_type_id\": $8 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- POSITION CREATED ----- $http_code"
   fi
}

function process_position_monthly_expense() {
   URL="$HOST/api/v1/monthly_expenses/position"
   IFS=' '

   echo "--- Inserting position_monthly_expense -> $1 $2 $3 $4 $5 $6"

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

   echo "--- Inserting position_daily_expense -> $1 $2 $3 $4"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"position_daily_expense\": { \"cost\": $1, \"description\": \"$2\", \"position_id\": $3, \"type_id\": $4 } }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- POSITION DAILY EXPENSE CREATED ----- $http_code"
   fi
}

function process_project_time_materials() {
   URL="$HOST/api/v1/projects"
   IFS=' '

   echo "--- Inserting project -> $1 $2 $3 $4 $5"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"project\": { \"name\": \"$1\", \"customer_id\": $2, \"region_id\": $3, \"status\": \"$4\", \"billing_type\": \"$5\"} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- TIME MATERIALS PROJECT CREATED ----- $http_code"
   fi
}

function process_project_retainer() {
   URL="$HOST/api/v1/projects"
   IFS=' '

   echo "--- Inserting project -> $1 $2 $3 $4 $5 $6"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"project\": { \"name\": \"$1\", \"customer_id\": $2, \"region_id\": $3, \"status\": \"$4\", \"amount\": \"$5\", \"billing_type\": \"$6\"} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- RETAINER PROJECT CREATED ----- $http_code"
   fi
}

function process_project_fixed_bid() {
   URL="$HOST/api/v1/projects"
   IFS=' '

   echo "--- Inserting project -> $1 $2 $3 $4 $5 $6"

   response=$($CURL -i --silent -w "\n%{http_code} " --location --request POST \
      $URL \
      -H "Content-Type: application/json" \
      --header "Authorization: $ACCESS_TOKEN" \
      --data-raw "{ \"project\": { \"name\": \"$1\", \"customer_id\": $2, \"region_id\": $3, \"status\": \"$4\", \"amount\": \"$5\", \"billing_type\": \"$6\"} }")

   http_code=$(tail -n1 <<<"$response")

   if [[ "$http_code" -ne 201 ]]; then
      MESSAGE=$(echo $response | jsonValue message)
      echo "Unable to continue : $http_code, $MESSAGE", $response
      exit 1;
   else
      echo "----- FIXED BID PROJECT CREATED ----- $http_code"
   fi
}
