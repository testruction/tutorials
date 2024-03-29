# 2. Activate NVM in the current terminal session

What NVM installs the fist time, it requires to start a new terminal session in order to be discovered using the `$PATH` variable.

To enable NVM to exectue in the current session, run the following commands:

```shell
export NVM_DIR="$HOME/.nvm" [ -s "$NVM_DIR/nvm.sh" ] \
&& \. "$NVM_DIR/nvm.sh" \
&& [ -s "$NVM_DIR/bash_completion" ] \
&& \. "$NVM_DIR/bash_completion"
```{{exec}}

Check that NVM is operable in the current session by checking the installed version.

```shell
nvm --version
```