# Usage [^](README.md)

Here should be what is required to use (and might be to future plan a new distribution).

## Notes
Clearly, this repo contains more than 3 iterations of ways to manage AST servers.  Therefore, it gets roff to document.


## Mgmt Service Granularely

 That attempt to simplify the launch, install (start|stop) of a stylizer entity.
## Recently Used

```sh
#

```
|       |       |       |
|  ---  |  ---  |  ---  |
| [launch-model_gia-ds-dbginko-v03-210809-864x_new-singleone.220407.sh](launch-model_gia-ds-dbginko-v03-210809-864x_new-singleone.220407.sh)       |       | Starts series of specified Checkpoints using next CLI Wrapper      |
|       |       |       |
|  [custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh](custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh)     |       |   CLI Wrapper    |
|       |       |       |
|  [__launch-docker-dev-specific-checkpoint-singleone.210606.sh](__launch-docker-dev-specific-checkpoint-singleone.210606.sh)     |       |Launch SingleOne       |
|       |       |       |
|   [_stop__ast_dbginko-v03-210809__fleet](_stop__ast_dbginko-v03-210809__fleet.sh)    |       |   Stop the Okoni Fleet    |
|       |       |       |
|  [_start__ast_dbginko-v03-210809__fleet.sh](_start__ast_dbginko-v03-210809__fleet.sh)     |       |   Start the Okoni Fleet    |
|       |       |       |
|       |       |       |




## Install
```sh
# Install Meta server (supply model information )
. install-httpd-meta-container.sh

```

# Separated by pattern

## Install

## install
|       |       |       |
|  ---  |  ---  |  ---  |
|[_batch_installer__210430.sh](_batch_installer__210430.sh)|    |  |
|     |     |     |
|[install-all.sh](install-all.sh)|    |--@STCGoal Prep the env. pull containers.    |
|     | --@STCStatus OUTDATED.    |     |
|[install-compo-all.sh](install-compo-all.sh)|    |--@STCGoal Start a pattern of Script  |
|     | --@STCStatus Must manually edit pattern    |     |
|[install-httpd-container.sh](install-httpd-container.sh)|    |  |
|     |     |     |
|[install-httpd-meta-container.sh](install-httpd-meta-container.sh)|    |--@STCGoal Install Meta AST Server  |
|     | --@STCStatus DEPRECATED.  Will be moved to all host - keep it here to stay compatible with new host and old ones    |     |
|[uninstall-all.sh](uninstall-all.sh)|    |--@STCGoal  Remove all container, stop them, a great cleanup  |
|     | --@STCStatus TODO    |     |


----


----

## Osiris
|     |     |     |
## siris
|       |       |       |
|  ---  |  ---  |  ---  |
|[Osiris-Make-Installer.sh](Osiris-Make-Installer.sh)|    |  |
|     |     |     |
|[__osiris_history_custom-start-docker-ast-compo__210617.sh](__osiris_history_custom-start-docker-ast-compo__210617.sh)|    |  |
|     |     |     |
|[_henv_osiris.astia.xyz.sh](_henv_osiris.astia.xyz.sh)|    |  |
|     |     |     |
|[osiris-launch-210618.sh](osiris-launch-210618.sh)|    |  |
|     |     |     |
## siris
|       |       |       |
|  ---  |  ---  |  ---  |
|[Osiris-Make-Installer.sh](Osiris-Make-Installer.sh)|    |--@STCGoal Generate D2 Install Script for Osiris Host (Cloud machine)   |
|     | --@STCStatus Existing generated script osiris-doubletwo.sh-****    |     |
|[__osiris_history_custom-start-docker-ast-compo__210617.sh](__osiris_history_custom-start-docker-ast-compo__210617.sh)|    |  |
|     |     |     |
|[_henv_osiris.astia.xyz.sh](_henv_osiris.astia.xyz.sh)|    |  |
|     |     |     |
|[osiris-launch-210618.sh](osiris-launch-210618.sh)|    |  |
|     |     |     |
