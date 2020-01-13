#!/bin/bash 

COMMAND=$1 
shift 
if [ "$COMMAND" == "bash" ]; then
 /bin/bash 
fi

if [ "$COMMAND" == "update" ] || [ "$COMMAND" == "updaterun" ]; then
  /opt/steamcmd/steamcmd.sh \
              +login anonymous \
              +force_install_dir /opt/insurgency \
              +app_update "581330 -beta community-exp" validate \
              +quit
fi
echo "copying teaked game config from /app/Insurgency/ to /opt/insurgency/Insurgency/"
cp -R /app/Insurgency/ /opt/insurgency/
sed s/RconPasswordAAA/$RCON_PASSWORD/ /app/Insurgency/Saved/Config/LinuxServer/Game.ini | sed s/RconPortAAA/$RCON_PORT/ | cat > /opt/insurgency/Insurgency/Saved/Config/LinuxServer/Game.ini
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
strMap="Farmhouse?Scenario=Scenario_Farmhouse_Checkpoint_Security"
echo "game port $GAME_PORT ,query port $QUERY_PORT, rcon port $RCON_PORT, server name $SERVER_NAME"   
/opt/insurgency/Insurgency/Binaries/Linux/InsurgencyServer-Linux-Shipping $strMap?MaxPlayers=$MAX_PLAYERS  -Port=$GAME_PORT -QueryPort=$QUERY_PORT -hostname="$SERVER_NAME"  -log  -MapCycle=MapCycle -NoEAC $@
fi
