# Cloud Workstation Remote Desktop

This repo contains helper scripts to facilitate long-lived Chrome Remote Desktop sessions on Google Cloud Workstations.

### Image Setup

The `setup.sh` script should be executed either on boot, or as part of the Dockerfile.  It installs the desktop environment as well as chrome remote desktop.  It does not set up the credentials for the connection.

The `150-copy-crd-state.sh` script should be executed on boot.  It can be added to `/etc/workstation-startup.d/`, for example, or somewhere else.  It copies the existing session if one exists.

The `save-crd-state.sh` script needs to be executed ONCE after a session has been established.  See instructions below:

### Save the Session State

0) SSH into the remote machine.  Have the terminal ready, we'll need it later.

1) Go to [https://remotedesktop.google.com/headless](https://remotedesktop.google.com/headless) on your local machine

2) Go through the "setup via ssh" menu, and get the Debian Linux setup script.  It should look something like:

```
DISPLAY= /opt/google/chrome-remote-desktop/start-host --code="4/0AQSTgQGp3kZoNYosW0yCNEVWpyWJKdSzlx3NExgVVr2V-X01770cnVqSJmLKQ0yHnroAHQ" --redirect-url="https://remotedesktop.google.com/_/oauthredirect" --name=$(hostname)
```

NB: the --code option is an auth code that is only valid briefly.  Basically, this step will tell your remote machine that your local machine is allowed access.

3) (time sensitive) Copy and paste that script into the remote machine SSH session.

4) Start the chrome-remote-desktop service

```
service chrome-remote-desktop start
```

5) Execute the `save-crd-state.sh` script to persist the tokens into the user's home folder.

Now, chrome-remote-desktop should be available when the computer is up.  The session tokens may expire, in which case you must go back through steps 1-5.

### To access chrome remote desktop:

1) at [https://remotedesktop.google.com/headless](https://remotedesktop.google.com/headless) on your local machine, go through the "remote access" menu to find your remote machine.

2) You now have a bare-bones linux machine to do stuff on. Try opening google chrome on the remote desktop and logging in.


# Disclaimer

This repository is a scientific product and is not official communication of the National Oceanic and
Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project
code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the
Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub
project will be governed by all applicable Federal law. Any reference to specific commercial products,
processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or
imply their endorsement, recommendation or favoring by the Department of Commerce. The Department
of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to
imply endorsement of any commercial product or activity by DOC or the United States Government.
