#!/bin/bash

COMMAND=$1
shift

if [ "$COMMAND" == "update" ] || [ "$COMMAND" == "updaterun" ]; then
  /opt/steamcmd/steamcmd.sh \
              +login anonymous \
              +force_install_dir /opt/insurgency \
              +app_update 581330 validate \
              +quit
fi   

if [ "$COMMAND" == "run" ] || [ "$COMMAND" == "updaterun" ]; then            
   /opt/insurgency/Insurgency/Binaries/Linux/InsurgencyServer-Linux-Shipping Oilfield?Scenario=Scenario_Refinery_Push_Security?MaxPlayers=28 -Port=27102 -QueryPort=27131 -log -hostname="0TestServer" $@
fi