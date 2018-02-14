#!/usr/bin/gawk -f
# vim:sts=4:sw=4:et
BEGIN {
    fstab="/etc/fstab"
    while((getline <fstab) > 0) {
        # Look for the longest column
        if (!(is_comment($0) || is_blank($0))) {
            c1 = (length($1) > c1) ? length($1) : c1
            c2 = (length($2) > c2) ? length($2) : c2
            c3 = (length($3) > c3) ? length($3) : c3
            c4 = (length($4) > c4) ? length($4) : c4
            c5 = (length($5) > c5) ? length($5) : c5
            c6 = (length($6) > c6) ? length($6) : c6
        }
        ll[++i] = $0
    }
    close(fstab)

    fmt = sprintf("%%-%d.%ds %%-%d.%ds %%-%d.%ds %%-%d.%ds %%-%d.%ds %%-%d.%ds\n", c1,c1, c2,c2, c3,c3, c4,c4, c5,c5, c6,c6)

    for (i=1; i <= length(ll); i++) {
        if (!(is_comment(ll[i]) || is_blank(ll[i]))) {
            split(ll[i], l)
            printf(fmt, l[1],l[2],l[3],l[4],l[5],l[6])
        } else {
            print ll[i]
        }
    }
}

function is_blank(s) {
    return (match(s, /^[:blank:]*$/))
}

function is_comment(s) {
    return (match(s, /^#|^[:blank:]*#/))
}
