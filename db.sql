CREATE USER C##admin_user IDENTIFIED BY pass;
GRANT DBA TO C##admin_user;
CONNECT C##admin_user/pass;

CREATE TABLESPACE consumers_data DATAFILE 'tbs_f2.dbf' SIZE 100M ONLINE;
CREATE TABLE consumers(
  cons_id NUMBER(10) PRIMARY KEY,
  cons_name VARCHAR(50) NOT NULL,
  cons_total_spent NUMBER(10,2) DEFAULT 0
) TABLESPACE consumers_data;
