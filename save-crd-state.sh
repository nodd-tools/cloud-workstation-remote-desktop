#!/bin/bash

echo "Saving Chrome Remote Desktop session state..."

# Define the persistent storage location
CRD_STATE_DIR="/home/user/.crd_state"

# Create the backup directories, ensuring any old state is cleared first
rm -rf "$CRD_STATE_DIR"
mkdir -p "$CRD_STATE_DIR/config"
mkdir -p "$CRD_STATE_DIR/opt"

# Copy the critical configuration files from their live locations
# to the persistent backup directory. This should be run right after
# the initial authorization is complete.
cp -r /home/user/.config/chrome-remote-desktop/* "$CRD_STATE_DIR/config/"
cp -r /opt/google/chrome-remote-desktop/* "$CRD_STATE_DIR/opt/"

# Ensure the backup files are owned by the user
chown -R user:user "$CRD_STATE_DIR"

echo "State saved successfully."
echo "Chrome Remote Desktop will now start automatically on subsequent reboots."

