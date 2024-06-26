USE ROLE ACCOUNTADMIN;

SET MY_USER = CURRENT_USER();

SELECT $MY_USER;

CREATE OR REPLACE ROLE SCHEMACHANGE_ROLE;

GRANT ROLE SCHEMACHANGE_ROLE TO ROLE SYSADMIN;

GRANT ROLE SCHEMACHANGE_ROLE TO USER IDENTIFIER($MY_USER);

GRANT EXECUTE TASK ON ACCOUNT TO ROLE SCHEMACHANGE_ROLE;

GRANT MONITOR EXECUTION ON ACCOUNT TO ROLE SCHEMACHANGE_ROLE;

GRANT IMPORTED PRIVILEGES ON DATABASE SNOWFLAKE TO ROLE SCHEMACHANGE_ROLE;

ALTER USER abhiramd7 SET RSA_PUBLIC_KEY='MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxwTf8KF2gz/Ox3/6nOyi
kMs/iSvcPkAJ+zqTCVidQphU7KtFN3RXaBM1X9609g8paZZZoXpKzE4ShSpo8Whq
YrzhyjJXAIf9hYgVZPQrw1j0aKdeRpS4hhrnbWtCn4ZntYwhEwR7tUo1Whm/1vjg
EvMFBwKAxJvMDBXbrKewBs34rqCGAaGBf4W2tm+sRUD57iEK9vEQd5n3aCivZ/cW
mLpEnHttyEl0NLStjRoB95GhL9MUBZ5KXl5vKoeLre/RKLDwf9LsUDD/0x2p4GpA
rI84Lj4bOZ6U6Ud31bL58cT/S+6QWCwuhm3tp0viKkTuvS9GDrxiNy1Vtc42HjVd
/wIDAQAB';

DESC USER abhiramd7;
SELECT TRIM((SELECT "value" FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()))
  WHERE "property" = 'RSA_PUBLIC_KEY_FP'), 'SHA256:');


CREATE OR REPLACE DATABASE  RH_DEMO_DB;

GRANT OWNERSHIP ON DATABASE RH_DEMO_DB TO SCHEMACHANGE_ROLE;

CREATE OR REPLACE WAREHOUSE  RH_DEMO_WH WITH WAREHOUSE_SIZE = 'XSMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 60 AUTO_RESUME = TRUE;


schemachange [-h] [--config-folder CONFIG_FOLDER] [-f ROOT_FOLDER] [-a SNOWFLAKE_ACCOUNT] [-u SNOWFLAKE_USER] [-r SNOWFLAKE_ROLE] [-w SNOWFLAKE_WAREHOUSE] [-d SNOWFLAKE_DATABASE] [-s SNOWFLAKE_SCHEMA] [-c CHANGE_HISTORY_TABLE] [--vars VARS] [--create-change-history-table] [-ac] [-v] [--dry-run] [--query-tag QUERY_TAG] [--oauth-config OUATH_CONFIG]