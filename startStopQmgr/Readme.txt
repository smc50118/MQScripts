FROM http://www.mqseries.net/phpBB2/viewtopic.php?t=19570

...
You will need to be root to do this. 
Put this file in /etc/rc.d. I call this one mqseries but the name doesn't matter. 

Go to /etc/rc.d/rc2.d and create 2 links to this file. 
K20mqseries -> ../mqseries 
S20mqseries -> ../mqseries 

The number, e.g. 20 can be any number that is not already assigned in this directory. The Sxxmqseries gets called when linux boots up in ring 2 and Sxxmqseries gets called when linux shuts down. 

Repeat this for each ring you want to start/stop MQ, i.e. rc3.d, rc4.d, etc 

Hope this helps, 
Charlie
