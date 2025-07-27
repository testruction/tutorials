#!/usr/bin/env bash

set -euo pipefail

sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin

task
