#!/usr/bin/env bash

set -euox pipefail

# Configurar teclado en español
cat << EOF > /etc/vconsole.conf
KEYMAP="es"
FONT="eurlatgr"
EOF

# Actualizar el sistema
dnf update -y
dnf install -y \
    oraclelinux-developer-release-el8 \
    oracle-database-preinstall-21c \
    jq

# Descargar rpm con oracle DB
wget -P /tmp https://download.oracle.com/otn-pub/otn_software/db-express/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
cat << EOF > /tmp/oracledb.sha256
f8357b432de33478549a76557e8c5220ec243710ed86115c65b0c2bc00a848db /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
EOF
sha256sum -c /tmp/oracledb.sha256

# Instalar oracle DB
dnf install -y /tmp/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm

# Modificar /etc/hosts
IP="$(ip -j a show scope global | jq -r '.[0].addr_info[0].local')"
HOSTNAME="$(hostname -s)"
DOMAIN="$(hostname)"
sed -i "s/^.*${DOMAIN}.*$/${IP} ${DOMAIN} ${HOSTNAME}/" /etc/hosts

# Configurar Oracle DB
# https://docs.oracle.com/en/database/oracle/oracle-database/21/xeinl/installing-oracle-database-free.html#GUID-3F29EE7C-4546-49EE-B894-027EE3E371BF
(echo "pass"; echo "pass";) | /etc/init.d/oracle-xe-21c configure

# Configurar variables de entorno en .bash_profile
ORACLE_HOME="/opt/oracle/product/21c/dbhomeXE"
cat << EOF >> /home/vagrant/.bash_profile
export ORACLE_HOME="${ORACLE_HOME}"
export PATH="\${ORACLE_HOME}/bin:${PATH}"
export ORACLE_SID="XE"
EOF

# Configurar servicio oracle-xe-21c
systemctl daemon-reload
systemctl start oracle-xe-21c
systemctl enable oracle-xe-21c
