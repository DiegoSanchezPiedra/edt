#! /bin/bash
# @edt ASIX-M06
# isx2031424
# diego sanchez
# -----------------

authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.edt.org' \
            --krb5adminserver='kserver.edt.org' --krb5realm='EDT.ORG' \
            --enablemkhomedir --updateall
