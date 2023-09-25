# Scalar

```bash
cat <<EOF | yq .
- Mark McGwire
- Sammy Sosa
- Ken Griffey
EOF
```

```bash
cat <<EOF | yq .text
text: |
  Should
  display
  on multiple lines
EOF
```

```bash
cat <<EOF | yq .text
text: |-
  Should
  display
  on multiple lines
  (without new line at the end)
EOF
```

```bash
cat <<EOF | yq .text
text: |+
  Should
  display
  on multiple lines
  (with a new line at the end)
EOF
```


```bash
cat <<EOF | yq .text
text: >
  Should
  display
  a single line
EOF
```

```bash
cat <<EOF | yq .text
text: >-
  Should
  display
  a single line
  (without new line at the end)
EOF
```

```bash
cat <<EOF | yq .text
text: >+
  Should
  display
  a single line
  (with a line at the end)
EOF
```

```bash
cat <<EOF | yq .
- 2001-07-23
? [ New York Yankees,Atlanta Braves ]
: [ 2001-07-02, 2001-08-12, 2001-08-14]
EOF
```

strange var:
  [10, 20, 30, {x: 1, y: 2}]

strange var:
  [10, 20 , 30, {x: 1, y: 2}]