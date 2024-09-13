FROM openjdk:8-jre-slim

# Set working directory
WORKDIR /app

# Copy necessary files
COPY . .

# Set the executable permissions for scripts
RUN chmod +x Install.sh ServerStart.sh settings.sh backup.sh test.sh

# Install Forge server
RUN ./Install.sh

# EULA test
RUN echo "eula=true" > eula.txt
# RUN echo "level-name=/WorldBackup/your_world_folder" > server.properties
# Expose the Minecraft server port
EXPOSE 25565

# Start cron and the Minecraft server testing
# CMD ./ServerStart.sh
CMD ./test.sh

