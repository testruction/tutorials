# 3. Install Node.JS versions

NVM has the ability to install the latest long-term supported version (LTS) without specifiying the exact [SemVer](https://semver.org).

Run to following command to install the latest version.

```shell
nvm install --lts
```{{exec}}

Let's install the [previous LTS version](https://endoflife.date/nodejs)

```shell
nvm install 22
```{{exec}}

Check the current active version.

```shell
node --version
```{{exec}}

> **Notice**: The latest installed version is automatically activated.

Reactivate the LTS, then check the version again.

```shell
nvm use --lts && node --version
```{{exec}}

Run the following command to activate the 18.x version.

```shell
nvm use 22
```{{exec}}
