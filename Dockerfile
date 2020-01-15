FROM bowmanhan/insurgency_sandstorm_server:base
LABEL maintainer="fancycode@gmail.com"
# Install, update & upgrade packages
# Create user for the server
# This also creates the home directory we later need
# Clean TMP, apt-get cache and other stuff to make the image smaller
# Create Directory for SteamCMD
# Download SteamCMD
# Extract and delete archive

COPY --chown=steam config_ins/Insurgency /app/Insurgency
# Add startup script
COPY --chown=steam startup.sh /app/startup.sh
COPY --chown=steam ./rconpp /app/
#RUN chmod +x /app/startup.sh
ENV GAME_PORT 27102
ENV QUERY_PORT 27131
ENV RCON_PORT 29100
ENV MAX_PLAYERS 10
ENV SERVER_NAME MagicGirl
ENV RCON_PASSWORD fdsaklf23$adsf
ENV GSLT=foo
ENV MAP_LIST=MapCycle
# Make server port available to host
EXPOSE ${GAME_PORT}/udp 
EXPOSE ${QUERY_PORT}/udp
EXPOSE ${RCON_PORT}/tcp

WORKDIR /opt/insurgency

USER steam
HEALTHCHECK --start-period=60s \
           CMD /app/rconpp -H 127.0.0.1 -P $RCON_PORT -p $RCON_PASSWORD --healthy
# Update and run insurgency
ENTRYPOINT ["/app/startup.sh"]

# Run in insurgency in console mode
CMD ["updaterun", "-console"]
