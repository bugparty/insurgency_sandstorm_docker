FROM debian:stretch-slim

# Install, update & upgrade packages
# Create user for the server
# This also creates the home directory we later need
# Clean TMP, apt-get cache and other stuff to make the image smaller
# Create Directory for SteamCMD
# Download SteamCMD
# Extract and delete archive
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		lib32stdc++6 \
		lib32gcc1 \
		wget \
		ca-certificates \
		nano \
	&& useradd -m steam \
	&& su steam -c \
		"mkdir -p /home/steam/steamcmd" \
       && apt-get clean autoclean \
        && apt-get autoremove -y \
        && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Create insurgency directory
RUN mkdir -p /opt/steamcmd \
    && mkdir -p /opt/insurgency
ADD  steamcmd_linux.tar.gz /opt/steamcmd
RUN chown steam -R /opt/steamcmd \
    && chown steam -R  /opt/insurgency


# Add startup script
ADD startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

# Make server port available to host
EXPOSE 27102/udp 
EXPOSE 27131/tcp

WORKDIR /opt/insurgency

USER steam
# Update and run insurgency
ENTRYPOINT ["/app/startup.sh"]

# Run in insurgency in console mode
CMD ["updaterun", "-console"]