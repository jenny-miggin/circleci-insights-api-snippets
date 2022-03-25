#!/bin/bash

set -e

# Parameters required to make up the org slug: 
VCS=""
ORG=""
PROJECT_NAME=""

MAIN_BRANCH=""
MAIN_WORKFLOW=""

NEW_BRANCH=""
NEW_WORKFLOW=""

CREDITS_MAIN=$(curl -s --request GET --url "https://circleci.com/api/v2/insights/${VCS}/${ORG}/${PROJECT_NAME}/workflows/{$MAIN_WORKFLOW}?branch={$MAIN_BRANCH}&circle-token=${CIRCLE_TOKEN}" | jq .items[0].credits_used)

CREDITS_NEW_BRANCH=$(curl -s --request GET --url "https://circleci.com/api/v2/insights/${VCS}/${ORG}/${PROJECT_NAME}/workflows/{$NEW_WORKFLOW}?branch={$NEW_BRANCH}&circle-token=${CIRCLE_TOKEN}" | jq .items[0].credits_used)

DIFFERENCE=$(($CREDITS_MAIN-$CREDITS_NEW_BRANCH))

echo "$MAIN_BRANCH Credits Used: $CREDITS_MAIN | $NEW_BRANCH Credits Used: $CREDITS_NEW_BRANCH | Difference: $DIFFERENCE"

if [[ $DIFFERENCE > 0 ]]; then
    echo "Credit % decrease: $(( ($CREDITS_MAIN/$DIFFERENCE)*100 ))%"
else 
    echo "Credit % increase: $(( ($CREDITS_MAIN/$DIFFERENCE)*-100 ))%"
fi
