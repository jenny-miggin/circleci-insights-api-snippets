# Get the last 30 durations for one particular job

## Prerequisites

A personal CircleCI API token saved as `CIRCLE_API_TOKEN`

## Limitations

The default build limit is  `limit=30`, but this limit can be increased to a max of 100

## How does it work?

1. Simply populate the following variables:

```bash

CIRCLE_DOMAIN - If cloud, use `circleci.com`. If server, enter the server domain
ORG_NAME - the name of your github org
PROJECT - the name of the project that contains the job you want to analyse
JOB_NAME - the name of the job you want to analyse
```

2. View the newly created `duration.csv` to get the info
