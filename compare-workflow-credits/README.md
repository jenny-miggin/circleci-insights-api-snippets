# How can I compare credit usage between branches for a particular workflow? 

## Prerequisites: 
- A personal CircleCI API token saved as `CIRCLE_TOKEN`

## Limitations:
- The script will use the last available workflow run for the selected branches.
- Currently works for 1 workflow at a time, but can be easily modified to cover other workflows.
- This may not be accurate as the most up to date credit information can be found in Plan Overview in the CircleCI UI.

## How does it work?
1. Simply populate the following variables:
```
VCS - Your Version Control System
ORG - Your organisation name
PROJECT_NAME - The project you would like to compare against

MAIN_BRANCH - Your main static branch
MAIN_WORKFLOW - The workflow from the main branch

NEW_BRANCH - Your new branch with CircleCI config changes
NEW_WORKFLOW - Your new workflow (if you have changed the name)
```
2. Run the script to get metrics around:
  - Credit usage for the workflow on the main branch
  - Credit usage for the workflow on the new branch
  - The difference between the 2 workflows
  - Percentage change in the 2 workflows

### Sample output:
```
main Credits Used: 12 | circleci-changes Credits Used: 8 | Difference: 4
Credit decrease: 300%
```