# prover deploy documentation

## Prequisities
- one ubuntu server with at least 350GB memory, 32cores, and GPU with at least 20GB memory.
- one user with `sudo` no password all permissions or you can add change the [shared-vars.yaml](vars/shared-vars.yaml) to add the `ansible_become_password` variable in your file.

## Configs need to change
- values of `rpc` for `mainnet` or `sepolia` in [shared-vars.yaml](vars/shared-vars.yaml), change the correct value to your own.
- values of `release_version` and `docker_tag` this is decided by our coordinator, pls confirm with us before you run this.
- values in [inventory](inventory/provers), update the correct value for your `sepolia|mainnet' and 'chunk|batch' provers.
- [optional] values of `pj_path` in [shared-vars.yaml](vars/shared-vars.yaml), here I use `/prover/go-prover-docker`, change this to the value you want to customize.

## How to deploy your prover
```
export env=mainnet|sepolia
export type=chunk|batch
export user=your_ssh_user
ansible-playbook  --ssh-extra-args='-o StrictHostKeyChecking=no' --private-key $your_key  prover-bootstrap.yaml  -u $user -e env=$env -e type=$type -i inventory/provers
# Reboot your prover manually, and finally launch this playbook
ansible-playbook  --ssh-extra-args='-o StrictHostKeyChecking=no' --private-key $your_key  prover-deploy.yaml  -u $user -e env=$env -e type=$type -i inventory/provers
```
