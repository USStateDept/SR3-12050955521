CREATE TABLE testtable
(
 ID INT NOT NULL PRIMARY KEY,
 ts TIMESTAMP NOT NULL
);

CREATE SEQUENCE s_testtable;

CREATE OR REPLACE TRIGGER t_u_testtable
   BEFORE INSERT
   ON testtable
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.ID IS NULL
   THEN
      SELECT s_testtable.NEXTVAL
        INTO :NEW.ID
        FROM DUAL;
   END IF;
   IF :NEW.ts IS NULL
   THEN
      SELECT SYSTIMESTAMP
        INTO :NEW.ts
        FROM DUAL;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END;
/


CREATE OR REPLACE TRIGGER t_u_testtable
   BEFORE UPDATE
   ON testtable
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
BEGIN
   IF :NEW.ts IS NULL
   THEN
      SELECT SYSTIMESTAMP
        INTO :NEW.ts
        FROM DUAL;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END;
/