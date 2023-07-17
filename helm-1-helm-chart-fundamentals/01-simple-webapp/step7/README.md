# Prefix Kubernetes resources

Add prefix to all resources names to distinguish `backend` and `frontend` related deployments.

> **Regular expression**:
> - *`^` asserts position at start of a line
> - `(` start of capturing group
> - `\s` matches any whitespace character
>   - `{2}` matches the previous token exactly 2 times
> - `name` matches the characters `name` literally (case sensitive)
> - `\:` matches the character `:` literally (case sensitive)
> - `\s` matches any whitespace character
> - `.` matches any character (except for line terminators)
>   - `*` matches the previous token between zero and unlimited times, as many times as possible, giving back as needed (greedy)
>   - `)` en of capturing group
> - `$` asserts position at the end of a line
> **Note**:
> With `sed` brackets `()` and curly bracket `{}` have to be escaped with a preceding slash `\` in order to be litterally outputed by the shell (i.e. `bash`, `sh`, `zsh`, etc.)

**Backend**:

```bash
sed -i 's/^\(\s\{2\}name\:\s.*\)$/\1-backend/g' chart/templates/backend/*.yaml
```{{exec}}

**Frontend**:

```bash
sed -i 's/^\(\s\{2\}name\:\s.*\)$/\1-frontend/g' chart/templates/frontend/*.yaml
```{{exec}}
