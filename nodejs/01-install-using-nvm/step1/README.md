# 1. Install Node Version Manager (NVM)

Install the OS package dependencies required to download and install NVM.

```shell
sudo apt-get update \
&& sudo apt-get install -y \
    'ca-certificates' \
    'curl' \
    'gnupg'
```{{exec}}

Create a variable containing the target version.

> Check the [NVM releases](https://github.com/nvm-sh/nvm/releases) to get a more recent version.

```shell
export NVM_VERSION='0.39.5'
```{{exec}}

Run the online script which installs NVM in your home directory.

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh | bash
```{{exec}}
