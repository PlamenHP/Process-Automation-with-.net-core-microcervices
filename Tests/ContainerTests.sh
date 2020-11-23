#!/bin/bash
declare -a urls=("http://localhost:8080/login" "http://identity/health" "http://dealers/health" "http://statistics/health" "http://notifications/health" "http://admin/health")

for url in "${urls[@]}" 
do
  count=0
  started=false
  echo "-----------------------------------------"
  echo "testing url: $url"

  until [ "$started" = true ] || [[ ( "$count" == 3 ) ]]; do
    count=$((count+1))
    echo "[$STAGE_NAME] Starting container [Attempt: $count]"

    testStart=$(curl --write-out '%{http_code}' --silent --output /dev/null $url)

    if [[ ( "$testStart" == 200 ) ]]; then
      started=true
      echo "Success"
      else
      sleep 5
    fi
  done

  if [ "$started" = false ]; then
    echo "Failure"
    exit 1
  fi
  
done