FROM openjdk:8-jre-slim

# Set working directory
WORKDIR /app

# Copy necessary files
COPY . .

# Set the executable permissions for scripts
RUN chmod +x Install.sh ServerStart.sh settings.sh backup.sh

# Install Forge server
RUN ./Install.sh

# EULA
RUN echo "eula=true" > eula.txt

# Expose the Minecraft server port
EXPOSE 25565

# Install cron for scheduling the backup job
RUN apt-get update && apt-get install -y cron

# Add the cron job for backup at 2:00 PM
RUN echo "0 14 * * * /app/backup.sh >> /var/log/backup.log 2>&1" >> /etc/crontab

# Start cron and the Minecraft server
CMD ["./ServerStart.sh"]
