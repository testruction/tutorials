# Search for content within files

Search for files containing a Name Server (i.e DNS server).

`find / -type f -exec grep -Hn 'nameserver' {} \;`

Now remove those files.

`find /var/lib/lab1 -type f -perm -go=w -exec rm -vf '{}' \;`

An error "Operation not permitted" is returned for some files. This might be caused by **extended attributes**.

Check the remaining files extended attributes.

`find /var/lib/lab1 -type f -perm -go=w -exec lsattr '{}' \;`

> Either the `i` (n. Immutable) or `a` (n. Append Only) attributes are displayed.

Unset the problematic extended attributes to the files.

`find /var/lib/lab1 -type f -perm -go=w -exec chattr -i -a '{}' \;`

Remove the problematic files.

`find /var/lib/lab1 -type f -perm -go=w -exec rm -vf '{}' \;`
