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

# Replace <UUID> with the correct UUID for MAXMOOHAHA. If you don't know it, remove the "uuid" key from the JSON.
add_operator

# Start the server.
start_server() {
    java -server -Xms${MIN_RAM} -Xmx${MAX_RAM} ${JAVA_PARAMETERS} -jar ${SERVER_JAR} nogui
}

echo "Starting Pixelmon Mod Server..."
start_server