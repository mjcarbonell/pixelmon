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
    echo "rcon.port=25575" >> server.properties

# Install cron and other necessary tools
RUN apt-get update && apt-get install -y cron curl zip

# Copy the world backup script and ensure it's executable
COPY world_backup.sh /app/world_backup.sh
RUN chmod +x /app/world_backup.sh

# Add cron job for world backup at 2:30 PM daily
RUN echo "30 14 * * * /app/world_backup.sh" >> /etc/crontab

# Check if the 'world' directory exists, rename if necessary, then start the server
CMD ["/bin/bash", "-c", "if [ -d './world' ]; then mv ./world ./world_backup_$(date +%Y%m%d_%H%M%S); fi && ./ServerStart.sh"]
