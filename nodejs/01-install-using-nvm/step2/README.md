# 2. Activate NVM in the current terminal session

What NVM installs the fist time, it requires to start a new terminal session in order to be discovered using the `$PATH` variable.

To enable NVM to execute in the current session, run the following commands:

```shell
export NVM_DIR="$HOME/.nvm"
```{{exec}}

Load the NVM environment

```shell
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```{{exec}}

Enabled command completion

```shell
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```{{exec}}

Check that NVM is operable in the current session by checking the installed version.

```shell
nvm --version
```
