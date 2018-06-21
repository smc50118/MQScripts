#!/bin/bash

Running_QMgr=$(dspmq -o all | \
        sed '/(Running)/!d' | \
        awk -F '[()]' '{print $2}')
exec
        endmqm ${Running_QMgr[@]}

echo ${Running_QMgr[@]} ' stopping'
#Is it dead yet?
sleep 5
#echo 'sleeping'

Stopped_QMgr=$(dspmq -o all | \
        sed '/(Ended normally)/!d' | \
        awk -F '[()]' '{print $2}')

echo ${Stopped_QMgr[@]} 'are currently stopped'
#echo 'Deleting the newly created QMgr '${Running_QMgr[@]}
#exec
#        dltmqm ${Running_QMgr}
#echo 'something went wrong'
#exit 10

