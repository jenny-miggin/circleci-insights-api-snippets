# !/bin/bash

CIRCLE_DOMAIN="circleci.com"
ORG_NAME="jenny-miggin"
PROJECT="testing"
JOB_NAME="disk-space-medium"

# Get job IDs for the specified job name
# https://circleci.com/docs/api/v1/index.html#recent-builds-for-a-single-project 

JOB_IDS=$(curl -s "https://$CIRCLE_DOMAIN/api/v1.1/project/github/$ORG_NAME/$PROJECT" -H "Circle-Token: $CIRCLE_API_TOKEN" | jq  -r --arg job_name "$JOB_NAME" '.[] | select(.workflows.job_name == $job_name ) | .build_num ')

# For each job id, get the duration and the start date & time
# https://circleci.com/docs/api/v2/index.html#operation/getJobDetails 

if [[ -z $JOB_IDS ]]; then
    echo "No job IDs found"
else
    for ID in $JOB_IDS
        do
            DURATION=$(curl -s "https://$CIRCLE_DOMAIN/api/v2/project/gh/$ORG_NAME/$PROJECT/job/$ID" -H "Circle-Token: $CIRCLE_API_TOKEN" | jq -r '.duration')
            START_DT=$(curl -s "https://$CIRCLE_DOMAIN/api/v2/project/gh/$ORG_NAME/$PROJECT/job/$ID" -H "Circle-Token: $CIRCLE_API_TOKEN" | jq -r '.started_at')
            # print to a .csv
            echo $START_DT,$JOB_NAME,$ID,$DURATION >> duration.csv
        done
fi