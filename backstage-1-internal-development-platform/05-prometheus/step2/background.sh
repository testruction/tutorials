#!/usr/bin/env bash

sudo systemctl restart k3s

kubectl proxy &
