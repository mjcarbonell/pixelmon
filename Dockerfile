# Use the official OpenJDK image as the base
FROM openjdk:8-jre-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    zip \
    rclone \
    cron \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create necessary directories
RUN mkdir -p /minecraft/server /minecraft/backups

# Copy your settings and scripts into the container
COPY settings.sh /minecraft/settings.sh
COPY Install.sh /minecraft/Install.sh
COPY ServerStart.sh /minecraft/ServerStart.sh
COPY backup.sh /minecraft/backup.sh

# Make your scripts executable
RUN chmod +x /minecraft/*.sh

# Run Install.sh to set up Forge
RUN /minecraft/Install.sh

# Copy the crontab file to the cron.d directory
RUN echo "0 * * * * /minecraft/backup.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/minecraft-backup

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/minecraft-backup

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Start cron service in the background
RUN service cron start

# Expose Minecraft port
EXPOSE 25565

# Start Minecraft server and cron in the same container
CMD cron && /minecraft/ServerStart.sh