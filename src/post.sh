#!/usr/bin/env bash

source ./functions.sh

for configuration in $(getConfigurations); do
  kernelVersionPostUpdate=$(getKernelVersion $configuration)
  kernelVersionPreUpdate=$(echo ${STATE_kernelVersionPreUpdate_!configuration}
  sshCommand=$(getSshCommandFromDeployRsConfiguration)

  if [ "$kernelVersionPreUpdate" == "$kernelVersionPostUpdate" ]; then
    echo "Kernel version for configuration \"${configuration}\" did not change"
    return
  fi

  echo "Kernel version for configuration \"${configuration}\" changed from ${kernelVersionPreUpdate} to ${kernelVersionPostUpdate}; rebooting..."
  eval "${sshCommand} 'systemctl reboot'"
done