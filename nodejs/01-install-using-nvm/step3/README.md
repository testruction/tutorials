# 3. Install Node.JS versions

NVM has the ability to install the latest long-term supported version (LTS) without specifiying the exact [SemVer](https://semver.org).

Run to following command to install the latest version.

```shell
nvm install --lts
```{{exec}}

Activate the LTS version.

```shell
nvm use --lts
```{{exec}}

Let's install the [previous LTS version](https://endoflife.date/nodejs)

```shell
nvm install 18
```{{exec}}

Check the current active version.

```shell
node --version
```{{exec}}

Activate the previous lts version and check the version again.

```shell
nvm use 18 && node --version
```{{exec}}
