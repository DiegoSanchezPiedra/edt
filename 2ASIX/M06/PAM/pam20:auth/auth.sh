#! /bin/bash
authconfig --enableshadow --enablelocauthorize --enableldap --enableldapauth --ldapserver='ldap' --ldapbase='dc=edt,dc=org' --enablemkhomedir --updateall
