#!/bin/bash

### parameters
api_token=$CIRCLE_API_TOKEN
org="felixshiftellecon"
repos=('snippetbox' 'circleci-playground')
datetoday=$(date +"%F")
dayrange="60" # number of days you want to report on

### report generation
echo "Starting to generate report..."
echo 'The current date is:' >> credit_report.csv
echo "$datetoday" >> credit_report.csv
echo '----------------------------------------------------------' >> credit_report.csv

for i in "${repos[@]}"
do
      echo "Populating report for $i"
      response=$(curl -s -u ${api_token}: https://circleci.com/api/v2/insights/gh/$org/$i/workflows?reporting-window=last-$dayrange-days)
      echo "$response" >> temp.csv
      echo "Total credits used during the last 60 days for ${i} is:" >> credit_report.csv
      response3=$(cat temp.csv | sed 's/.*"total_credits_used" : //' | cut -d " " -f 1 | sed -e '/^$/d' | sed '/^{/d' | sed '/^}/d' | sed 's/\(. *\),/\1/' | awk '{s+=$1} END {print s}')
      echo "$response3" >> credit_report.csv
      echo '----------------------------------------------------------' >> credit_report.csv
      rm temp.csv

done
echo "Finished report!"