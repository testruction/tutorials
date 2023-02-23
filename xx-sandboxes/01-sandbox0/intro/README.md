## Sandbox0


Operation | Script
--------- | ------
Create local users and groups | `./write-localusers.sh`{{execture}}
Install OpenSSH | `./install-ssh.sh`{{execture}}
Install LXD | `./install-ssh.sh && ./install-lxd.sh`{{execture}}
Create loopback ISCSI drives (default: 16*512MB) | `./install-iscsi.sh 8`{{execture}}
Generate files with random name, attributes and permissions | `./write-files.sh`{{execture}}
Generate files with random name, attributes, permissions and owners | `write-localusers.sh && ./write-files.sh`{{execture}}
