#!/bin/bash

rm -R /opt/sta/
rm ../.assembler_already_ran 
userdel sta
update-rc.d -f sta remove
rm /etc/init.d/sta
