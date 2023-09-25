# Record changes to the Git history

Configurer commit user name and email.

```bash
git config user.name 'Helm Student'
git config user.email 'student.helm@testruction.lab'
```{{exec}}

Stage changes in Git.

```bash
git add .
```{{exec}}

Check the status of Git.

```bash
git status
```{{exec}}

> Notice that deleted files does not appear in the list.

Review the content of all changes.

```bash
git status -v
```{{exec}}

Record the staged changes.

```bash
git commit -m 'Initial helm chart commit'
```{{exec}}
