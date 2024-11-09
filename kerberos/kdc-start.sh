#!/bin/bash

set -e

if [ ! -f /var/lib/krb5kdc/principal.kadm5.lock ]; then
    echo "[INFO] init database & admin..."
    # Create Kerberos database
    kdb5_util create -s -r UNEY.COM -P uneysecretpassword
    # Create admin principal
    kadmin.local -q "addprinc admin/admin"
fi

if [ ! -f /var/lib/keytabs/jduke.keytab ]; then
    kadmin.local -q "addprinc -randkey jduke@UNEY.COM"
    kadmin.local -q "ktadd -k /var/lib/keytabs/jduke.keytab jduke@UNEY.COM"
fi

if [ ! -f /var/lib/keytabs/broker.keytab ]; then
    kadmin.local -q "addprinc -randkey kafka/kafka@UNEY.COM"
    kadmin.local -q "ktadd -k /var/lib/keytabs/broker.keytab kafka/kafka@UNEY.COM"
fi

if [ ! -f /var/lib/keytabs/krbtgt.keytab ]; then
    kadmin.local -q "addprinc -randkey krbtgt/UNEY.COM@UNEY.COM"
    kadmin.local -q "ktadd -k /var/lib/keytabs/krbtgt.keytab krbtgt/UNEY.COM@UNEY.COM"
fi

krb5kdc -n