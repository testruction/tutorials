#!/usr/bin/env bash
# will run in background. can setup various things for the scenario for user not to see
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
echo "done" >> /tmp/killercoda-finished
task --taskfile "${HOME}/Taskfile.yaml" hello-world
echo "done" >> /tmp/killercoda-background-finished
