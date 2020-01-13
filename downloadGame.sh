#!/bin/bash
COMMAND=$1
shift
if [ -z $COMMAND ] 
then
  /home/steam/steamcmd/steamcmd.sh \
    +login anonymous \
    +force_install_dir /opt/insurgency \
    +app_update 581330 validate \
    +quit
else

  /home/steam/steamcmd/steamcmd.sh \
              +login anonymous \
              +force_install_dir /opt/insurgency \
              +app_update "581330 -beta community-exp" validate \
              +quit

fi
