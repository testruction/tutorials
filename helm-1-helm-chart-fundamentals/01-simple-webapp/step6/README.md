# Reflect the new configuration structure in the templates

Update `backend` and `frontend` YAML templates according to the new `values.yaml` structure.

> **Regular expression**:
> - `\.` matches the character `.` literally (case sensitive)
> - `Values` matches the characters `Values` literally (case sensitive)
> - `\.` matches the character `.` literally (case sensitive)

**Backend**:

```bash
sed -i 's/\.Values\./.Values.backend./g' chart/templates/backend/*.yaml
```{{exec}}

**Frontend**:

```bash
sed -i 's/\.Values\./.Values.frontend./g' chart/templates/frontend/*.yaml
```{{exec}}
