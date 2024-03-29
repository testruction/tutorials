#!/usr/bin/env bash

FILE=/ks/wait-init.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done; bash ${FILE}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

clear