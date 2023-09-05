#!/bin/bash

##  file-name       : test-if.sh
##  description     :    
##
##  contact         : jsabino
##  created         : 2021/06/29 13:17:21  (by jsabino)
##  updated         :


function test-if {
if ! ${?} ; then
    echo "should exit"
else
    echo "moving on"
fi
}
