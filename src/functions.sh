# evaluate nixosConfiguration and print all nixosConfigurations to stdout
function getConfigurations() {
  for configuration in $(nix eval --json --read-only .#nixosConfigurations --apply 'builtins.attrNames' | jq -c '.[]'); do
    echo $configuration
  done
}

# evaluate the given nixosConfiguration and print the kernel version to stdout
function getKernelVersion() {
  nix eval --raw --read-only .#nixosConfigurations.${1}.config.boot.kernelPackages.kernel.version
}

# evaluate the given deploy-rs host configuration and print the ssh command of the given profile to stdout
function getSshCommandFromDeployRsConfiguration() {
  host=$(nix eval --raw --read-only .#deploy.nodes.${1}.hostname)
  sshOpts=$(nix eval --raw --read-only .#deploy.nodes.${1}.sshOpts --apply 'builtins.concatStringsSep " "')
  user=$(nix eval --raw --read-only \
    .#deploy.nodes.${1}.profiles \
    --apply "profiles: if (profiles ? ${2}.sshUser) then profiles.${2}.sshUser else \"root\"" \
  )
  echo "ssh ${sshOpts} ${user:=root}@${host}"
}