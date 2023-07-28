#!/usr/bin/env bash

source ./functions.sh

for configuration in $(getConfigurations); do
  kernelVersion=$(getKernelVersion $configuration)
  echo "kernelVersionPreUpdate_${configuration}=${kernelVersion}" >> "$GITHUB_STATE"
  echo "Kernel pre-update kernel version for configuration \"${configuration}\" is ${kernelVersion}"
done
