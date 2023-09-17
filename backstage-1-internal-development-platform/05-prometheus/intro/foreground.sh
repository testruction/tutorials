#!/usr/bin/env bash

FILE=/ks/wait-init.sh; while ! test -f ${FILE}; do clear; sleep 0.1; done; bash ${FILE}

systemctl stop k3s \
&& cd ~/backstage-tutorial/ \
&& yarn  install \
&& yarn tsc \
&& systemctl start k3s
