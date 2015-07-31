#!/bin/bash

CONFIGURATION_PATH="/usr/local/etc/beid-fwd.cfg"

if [ ! -f "$CONFIGURATION_PATH" ]; then
    echo "BeID Forwarder configuration not found at $CONFIGURATION_PATH"
    exit 1
fi

# Change working directory to script directory
cd "$(dirname "$0")"

# Include configuration
. $CONFIGURATION_PATH

# Set default values for configuration
: ${BEID_CLI_PATH:="/usr/local/share/beid-fwd/beid-cli.jar"}
: ${HTTP_ENDPOINT:="http://localhost"}

if [ ! -f "$BEID_CLI_PATH" ]; then
    echo "BeID CLI not found at $BEID_CLI_PATH"
    exit 1
fi

# Detect java/cURL
JAVA_PATH=$(which java)
CURL_PATH=$(which curl)

if [[ -z "$JAVA_PATH" ]]; then
    echo "Java not found"
    exit 1
fi

if [[ -z "$CURL_PATH" ]]; then
    echo "cURL not found"
    exit 1
fi

# Start BeID CLI tool and read output
while read -r line
do
    # Attempt to forward data
    $CURL_PATH -s -f -i -X POST -d "$line" "$HTTP_ENDPOINT" --show-error -o /dev/null

    if [ $? -eq 0 ]; then
        echo "Successfully forwarded ${#line} bytes to $HTTP_ENDPOINT"
    else
        echo "Failed to forward ${#line} bytes to $HTTP_ENDPOINT: ${line}"
    fi
done < <($JAVA_PATH -jar "$BEID_CLI_PATH")
