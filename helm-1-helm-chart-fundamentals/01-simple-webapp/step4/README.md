# Create configuration sections for earch components

Create distinct sections for `backend` and `frontend` services in the `Values.yaml`.

Open the configuration file using `vi`.

```bash
vi chart/values.yaml
```{{exec}}

Type the following command to position the cursor at the `ReplicaCount` line.

```text
:/ReplicaCount
```

Indent all configuration properties and associated comments.

1. Press **`<Shift+v>`** to enter in Visual Line selection mode
2. Press **`<Ctrl+End>`** to select all lines down to the end of the file
3. Press **`>`** key to indent all lines (i.e two whitespaces)

Add the `backend` configuration section.

1. Type **`/replicaCount`** to position again at the begining at the `replicaCount` line
2. Using the **`<Arrow keys>`**, position the cursor on the line above the `replicaCount` configuration property.
3. Press **`<Insert>`** to enter in Insert mode (i.e Edit)
4. Add a blank line by pressing **`<Enter>`**.
5. Type `backend:`
6. Press **`<Esc>`** to enter back in Command mode

Add the `frontend` configuration section.

1. Using the **`<Arrow keys>`**, position the cursor at the `replicaCount` line
2. Press **`<Shift+v>`** to enter in Visual Line selection mode
3. Press **`<Ctrl+End>`** to select all lines down to the end of the file
4. Type **`y`** to copy (yank) selected lines
5. Press **`<Esc>`** to enter back in Command mode
6. Press **`<Insert>`** to enter in Insert
7. Press **`<Ctrl+End>`** to position the cursor at the end of the file
8. Press **`<Enter>`** two times to add two blank lines
9. Type **`frontend:`** then press **`<Enter>`** to add blank line at the end of the file
10. Press **`<Esc>`** to enter back in Command mode
11. Press **`p`** to paste the content below the `frontend:` configuration section
12. type **`:wq`** to save the change and quit `vi`
