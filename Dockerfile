FROM openjdk:8-jre-slim

# Set working directory
WORKDIR /app

# Copy necessary files
COPY . .

# Set the executable permissions for scripts
RUN chmod +x Install.sh ServerStart.sh settings.sh

# Install Forge server
RUN ./Install.sh

# EULA
RUN echo "eula=true" > eula.txt

# Expose the Minecraft server port
EXPOSE 25565 

# Enable RCON in server.properties
RUN echo "enable-rcon=true" >> server.properties && \
    echo "rcon.password=your_password_here" >> server.properties && \
    echo "rcon.port=25575" >> server.properties && \
    echo "level-name=world" >> server.properties

# Install cron
RUN apt-get update && apt-get install -y cron curl

# Copy the cronjob file and the script to send the world link
COPY world_backup.sh /app/world_backup.sh
RUN chmod +x /app/world_backup.sh

# Add cron job to download world and post link at 2:30 PM daily
RUN echo "30 14 * * * /app/world_backup.sh" >> /etc/crontab

# Start cron and the Minecraft server
CMD cron && ./ServerStart.sh
