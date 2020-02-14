-- Creating new user
DROP USER madang CASCADE;
CREATE USER madang IDENTIFIED BY madang;

-- Granting authorities to the new user
GRANT CONNECT, RESOURCE TO madang;
GRANT CREATE VIEW, CREATE SYNONYM TO madang;

-- Unlocking the new user
ALTER USER madang ACCOUNT UNLOCK;