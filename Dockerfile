FROM openjdk:8-jre-slim

# Set working directory
WORKDIR /app

# Copy necessary files
COPY . .

# Set the executable permissions for scripts
RUN chmod +x Install.sh ServerStart.sh settings.sh

# Install Forge server
RUN ./Install.sh

# Expose the Minecraft server port
EXPOSE 25565

# Start the server
CMD ["./ServerStart.sh"]