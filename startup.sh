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
echo "copying teaked game config from /app/Insurgency/ to /opt/insurgencyInsurgency/"
cp -R /app/Insurgency/ /opt/insurgency/Insurgency/
if [ "$COMMAND" == "run" ] || [ "$COMMAND" == "updaterun" ]; then      
#Everytime the server start up or restart, it will start with a random map

strMapList=()
strMapList+=("Canyon?Scenario=Scenario_Crossing_Checkpoint_Insurgents")
strMapList+=("Canyon?Scenario=Scenario_Crossing_Checkpoint_Security")
strMapList+=("Farmhouse?Scenario=Scenario_Farmhouse_Checkpoint_Insurgents")
strMapList+=("Farmhouse?Scenario=Scenario_Farmhouse_Checkpoint_Security")
strMapList+=("Mountain?Scenario=Scenario_Summit_Checkpoint_Insurgents")
strMapList+=("Mountain?Scenario=Scenario_Summit_Checkpoint_Security")
strMapList+=("OilField?Scenario=Scenario_Refinery_Checkpoint_Insurgents")
strMapList+=("OilField?Scenario=Scenario_Refinery_Checkpoint_Security")
strMapList+=("Precinct?Scenario=Scenario_Precinct_Checkpoint_Insurgents")
strMapList+=("Precinct?Scenario=Scenario_Precinct_Checkpoint_Security")
strMapList+=("Town?Scenario=Scenario_Hideout_Checkpoint_Insurgents")
strMapList+=("Town?Scenario=Scenario_Hideout_Checkpoint_Security")

#set random seed
RANDOM=$$$(date +%N)

#set map
strMap=${strMapList[$RANDOM % ${#strMapList[@]}]}      
   /opt/insurgency/Insurgency/Binaries/Linux/InsurgencyServer-Linux-Shipping $strMap?MaxPlayers=20 -Port=27102 -QueryPort=27131 -log  -MapCycle=MapCycle -NoEAC $@
fi