#!/bin/bash

##  file-name       : create-devops-task.sh
##  description     : automatically create a devops task on a board
##
##  contact         : jsabino
##  created         : 2021/06/29 12:43:38  (by jsabino)
##  updated         :




result="$(az boards work-item create  --organization 'https://dev.azure.com/MOServices'   --project 'Bilaterals'   \
               --type 'task'   --area 'Bilaterals\Dev Team'   --iteration "Bilaterals\Sprint ${sprint}"   \
               --title 'test cli creation'    --description='creating a task for a pbi via cli'   \
               --assigned-to 'Jorge Sabino' \
               --fields Priority='2' Tags='24,Ceremony Time Dev' Microsoft.VSTS.Scheduling.OriginalEstimate='2.5' \
         )"


curr_id="$(echo "${result}" | tee /dev/tty | jq .id)"

az boards work-item relation add --organization 'https://dev.azure.com/MOServices' \
    --id "${curr_id}" --relation-type "parent" --target-id "5622"
