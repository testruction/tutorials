# Create Backstage application

Run the following command to create the Backage application named **backstage-tutorial**.

```bash
echo "backstage-tutorial" | npx @backstage/create-app@latest
```{{exec}}

> The creation process takes approximatly **5 minutes**.

Move to the newly created application directory

```bash
cd backstage-tutorial/
```{{exec}}

Initialize the directory as Git repository.

```bash
git init
git config user.name "Backstage Tutorial"
git config user.email "backstage.tutorial@killercoda.com"
git add .
git commit -m 'Initial commit'
```{{exec}}