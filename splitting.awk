#!/usr/bin/awk -f
BEGIN {
    FS="[[:space:]=]"
}

/^[^[]/ {
    split($1, fqdn, /[.]/)
    print $3, $1, fqdn[1]
}
