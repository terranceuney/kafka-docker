#!/bin/bash

set -e

if [ ! -f /var/lib/krb5kdc/principal.kadm5.lock ]; then
    echo "[INFO] init database & admin..."
    # Create Kerberos database
    kdb5_util create -s -r KERBEROS.EXAMPLE -P uneysecretpassword
    # Create admin principal
    kadmin.local -q "addprinc admin/admin"
fi

if [ ! -f /var/lib/keytabs/jduke.keytab ]; then
    kadmin.local -q "addprinc -randkey jduke@KERBEROS.EXAMPLE"
    kadmin.local -q "ktadd -k /var/lib/keytabs/jduke.keytab jduke@KERBEROS.EXAMPLE"
fi

if [ ! -f /var/lib/keytabs/broker.keytab ]; then
    kadmin.local -q "addprinc -randkey kafka/broker.kerberos.example@KERBEROS.EXAMPLE"
    kadmin.local -q "ktadd -k /var/lib/keytabs/broker.keytab kafka/broker.kerberos.example@KERBEROS.EXAMPLE"
fi

if [ ! -f /var/lib/keytabs/krbtgt.keytab ]; then
    kadmin.local -q "addprinc -randkey krbtgt/KERBEROS.EXAMPLE@KERBEROS.EXAMPLE"
    kadmin.local -q "ktadd -k /var/lib/keytabs/krbtgt.keytab krbtgt/KERBEROS.EXAMPLE@KERBEROS.EXAMPLE"
fi

krb5kdc -n