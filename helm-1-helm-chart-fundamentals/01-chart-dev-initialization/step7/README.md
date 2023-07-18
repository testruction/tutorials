# Suffix Kubernetes resources

Add prefix to all resources names to distinguish `backend` and `frontend` related deployments.

> **Regular expression**:
> - `^` asserts position at start of a line
> - `(` start of capturing group
> - `\s` matches any whitespace character
>   - `{2}` matches the previous token exactly 2 times
> - `name` matches the characters `name` literally (case sensitive)
> - `\:` matches the character `:` literally (case sensitive)
> - `\s` matches any whitespace character
> - `.` matches any character (except for line terminators)
>   - `*` matches the previous token between zero and unlimited times, as many times as possible, giving back as needed (greedy)
> - `)` end of capturing group
> - `$` asserts position at the end of a line

> **Warning**:
> When using `sed`, brackets `()` and curly bracket `{}` have to be escaped with a preceding slash `\` in order to be litterally outputed by the shell (i.e. `bash`, `sh`, `zsh`, etc.)

**Backend**:

```bash
sed -i 's/^\(\s\{2\}name\:\s.*\)$/\1-backend/g' chart/templates/backend/*.yaml
```{{exec}}

**Frontend**:

```bash
sed -i 's/^\(\s\{2\}name\:\s.*\)$/\1-frontend/g' chart/templates/frontend/*.yaml
```{{exec}}

Stage changes in Git.

```bash
git add .
```{{exec}}

Review the content of all changes.

```bash
git status -v
```{{exec}}

> Each Kubernetes resource is now suffixed with their appropriate service.

Record the staged changes.

```bash
git commit -m 'Added component suffix to resources name'
```{{exec}}
