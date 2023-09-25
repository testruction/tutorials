# Create the Python virtual environment

[Virtual environments](https://packaging.python.org/en/latest/tutorials/installing-packages/#creating-virtual-environments) provide a simple solution to a lot of problems when developping multime projects on the same compter.
In particular, they help you to:

* **Resolve dependency issues** by allowing you to use different versions of a package for different projects. For example, you could use Package A v2.7 for Project X and Package A v1.3 for Project Y.
* Make your project **self-contained and reproducible** by capturing all package dependencies in a requirements file.
* Install packages on a host on which you do not have admin privileges.
* Keep your global `site-packages/` directory tidy by removing the need to install packages system-wide which you might only need for one project.

Install the `venv` package.

```bash
sudo apt install -y python3-venv
```{{execute}}


Create the `.venv` virtual environment.

```bash
python3 -m venv .venv/
```{{execute}}

> **Reminder**: A virtual virtual environment is nothing but


Activate the the virtual environment

```bash
source .venv/bin/activate
```
