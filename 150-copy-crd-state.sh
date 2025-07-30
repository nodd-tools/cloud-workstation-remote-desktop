#!/bin/bash

# Define the location in the persistent home directory for storing CRD state
CRD_STATE_DIR="/home/user/.crd_state"

# Check if a saved state exists by looking for the backup directories
if [ -d $CRD_STATE_DIR ]; then
    echo "Found existing Chrome Remote Desktop state. Restoring..."

    # Restore the user-specific config files. The target directory is already persistent,
    # but we restore to ensure consistency with our backup.
    # This also handles cases where a user might have accidentally deleted it.
    mkdir -p /home/user/.config/chrome-remote-desktop
    cp -r "$CRD_STATE_DIR/config/"* /home/user/.config/chrome-remote-desktop/

    # Restore the system-level config files to the ephemeral /opt directory.
    # This is the critical step to persist the authorization.
    sudo cp -r "$CRD_STATE_DIR/opt/"* /opt/google/chrome-remote-desktop/

    # Ensure the restored files have the correct ownership
    sudo chown -R user:user /home/user/.config/chrome-remote-desktop

    echo "State restored. Starting Chrome Remote Desktop service..."
    # Start the service, which will now use the restored credentials
    service chrome-remote-desktop start
else
    # This block runs only on the first start, or if the state has never been saved.
    echo "No saved Chrome Remote Desktop state found."
    echo "To persist your session after completing the initial setup, run the 'save-crd-state' command in a terminal."
fi
