#!/bin/bash

set -euo pipefail

# Variables
NUEVO_USUARIO="nuevo_usuario"
PASSWORD="contrasena_segura"
TABLE_NAME="nueva_tabla"
TABLE_COLUMNS="id NUMBER PRIMARY KEY, nombre VARCHAR2(50), cantidad NUMBER"
BACKUP_FILE="/home/oracle/backup_${TABLE_NAME}.sql"

# Conexión a Oracle XE y creación de usuario, tabla, registros y backup
sqlplus sys/pass as sysdba << EOF
-- Completar los comandos necesarios para:
-- 1. Crear el nuevo usuario en Oracle XE con la contraseña $PASSWORD
CREATE USER C##${NUEVO_USUARIO} IDENTIFIED BY ${PASSWORD};

-- 2. Otorgar permisos básicos al nuevo usuario
GRANT DBA TO C##${NUEVO_USUARIO};

-- Conectar como el nuevo usuario y crear la tabla $TABLE_NAME con las columnas especificadas en $TABLE_COLUMNS
CONNECT C##${NUEVO_USUARIO}/${PASSWORD}
CREATE TABLESPACE usuarios_data DATAFILE 'usuarios_data.dbf' SIZE 100M ONLINE;
CREATE TABLE ${TABLE_NAME}(${TABLE_COLUMNS});

-- Insertar cuatro registros de ejemplo en la tabla
INSERT INTO ${TABLE_NAME}(id, nombre, cantidad) VALUES
  (1, 'John Doe', 100);
INSERT INTO ${TABLE_NAME}(id, nombre, cantidad) VALUES
  (2, 'Jane Smith', 200);
INSERT INTO ${TABLE_NAME}(id, nombre, cantidad) VALUES
  (3, 'Clark Kent', 1000);
INSERT INTO ${TABLE_NAME}(id, nombre, cantidad) VALUES
  (4, 'Lex Luthor', 100000);

-- Realizar el backup de la tabla guardando los datos en $BACKUP_FILE echo "Usuario, tabla y registros creados exitosamente. Backup guardado en $BACKUP_FILE."
EOF
