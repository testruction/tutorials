#!/usr/bin/env bash

sudo systemctl restart kubelet

kubectl proxy &
