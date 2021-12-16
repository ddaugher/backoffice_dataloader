#!/bin/bash

ACCESS_TOKEN=''
HOST=''
USER_LIST=''
PROGRAM_NAME=$0

function usage() {
   clear
   echo "-----------------------------------------------------------------------------------------"
   echo "This script will apply necessary api access privileges for the backoffice ReST endpoints."
   echo ""
   echo "usage: $PROGRAM_NAME [--token access_token] [-userids ids] [--host hostname]"
   echo ""
   echo " --host http://localhost:4000     hostname of 'backend' server'"
   echo " --token access_token             specify access_token received during login"
   echo " --userids 1 2 4                  list of user ids"
   echo "-----------------------------------------------------------------------------------------"

   exit 1
}

# if less than six arguments supplied, display usage
if [ $# -le 5 ]; then
   usage
   exit 1
fi

# check whether user had supplied -h or --help . If yes display usage
if [[ ($# == "--help") || $# == "-h" ]]; then
   usage
   exit 0
fi

while :; do
   echo $1
   case "$1" in
   --host)
      shift
      HOST="$1"
      shift
      ;;
   --token)
      shift
      ACCESS_TOKEN="$1"
      shift
      ;;
   --userids)
      shift
      while ! echo "$1" | egrep '^-' >/dev/null 2>&1 && [ ! -z "$1" ]; do
         USER_LIST="$USER_LIST $1"
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

CURL='/usr/bin/curl'
URL="$HOST/api/v1/api_user_authorizations"

USER_LIST=$USER_LIST | xargs -n1 | sort | xargs
complete_list=$(echo {1..200})
COMPLETE_LIST_ORDERED=$(echo ${complete_list[*]} | xargs -n1 | sort -V | xargs)

for access_auth in $COMPLETE_LIST_ORDERED; do
   for user in $USER_LIST; do
      echo $access_auth/$user

      $CURL -v --silent --location --request POST \
         $URL \
         -H "Content-Type: application/json" \
         --header "Authorization: $ACCESS_TOKEN" \
         --data-raw '{"api_user_authorization": { "active": true, "access_authorization_id": '$access_auth', "user_id": '$user' } }' \
         2>&1 | grep "Not Authenticated\|access_authorization\|unique_user_access_authorization" &
   done
   wait
done
