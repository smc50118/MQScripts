#! /bin/sh 
# 

# init the rc.status env 
. /etc/rc.status 

echo "Running Prototype RC for MQSeries " 
rc_reset 

case "$1" in 
start) 
        echo -n "Starting WebSphere MQSeries" 
        su - mqm -c "cd /opt/mqm/bin; ./strmqm yourqmgr " 
        su - mqm -c "cd /opt/mqm/bin; ./strmqcsv yourqmgr " 
        su - mqm -c "cd /opt/mqm/bin; ./runmqlsr -m yourqmgr -t TCP -p 1414 & " 
        su - mqm -c "cd /opt/mqm/bin; ./runmqtrm -q YOUR.INIT.QUEUE -m yourqmgr & " 

        rc_status -v 
        ;; 

stop) 
        echo -n "Stoping WebSphere MQSeries" 
        su - mqm -c "cd /opt/mqm/bin; ./endmqm -i yourqmgr " 
        su - mqm -c "cd /opt/mqm/bin; ./endmqlsr -m yourqmgr & " 

        rc_status -v 
        ;; 


restart) 
        echo -n "Restarting WebSphere MQSeries" 
        su - mqm -c "cd /opt/mqm/bin; ./endmqm -i yourqmgr" 
        su - mqm -c "cd /opt/mqm/bin; ./endmqlsr -m yourqmgr& " 
        su - mqm -c "cd /opt/mqm/bin; ./strmqm yourqmgr" 
        su - mqm -c "cd /opt/mqm/bin; ./strmqcsv yourqmgr" 
        su - mqm -c "cd /opt/mqm/bin; ./runmqlsr -m yourqmgr-t TCP -p 1414 & " 
        su - mqm -c "cd /opt/mqm/bin; ./runmqtrm -q YOUR.INIT.QUEUE -m yourqmgr& " 

        rc_status 
        ;; 

status) 
        echo -n "WebSphere MQSeries status " 
        su - mqm -c "cd /opt/mqm/bin; ./dspmq " 
        su - mqm -c "cd /opt/mqm/bin; ./dspmqcsv " 

        rc_status -v 
        ;; 

*) 
        echo "Usage: $0 { start | stop | restart | status }" 
        exit 1 
        ;; 
esac 
rc_exit 0 
