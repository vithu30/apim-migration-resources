ALTER TABLE AM_WORKFLOWS ADD (
  WF_METADATA BLOB DEFAULT NULL NULL,
  WF_PROPERTIES BLOB DEFAULT NULL NULL,
)
/

CREATE TABLE AM_GW_PUBLISHED_API_DETAILS (
  API_ID varchar(255) NOT NULL,
  TENANT_DOMAIN varchar(255),
  API_PROVIDER varchar(255),
  API_NAME varchar(255),
  API_VERSION varchar(255),
  PRIMARY KEY (API_ID)
)
/

CREATE TABLE AM_GW_API_ARTIFACTS (
  API_ID varchar(255) NOT NULL,
  ARTIFACT blob,
  GATEWAY_INSTRUCTION varchar(20),
  GATEWAY_LABEL varchar(255),
  TIME_STAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (GATEWAY_LABEL, API_ID),
  FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON DELETE CASCADE
)
/

CREATE OR REPLACE TRIGGER update_timestamp
    BEFORE INSERT OR UPDATE ON AM_GW_API_ARTIFACTS
    FOR EACH ROW
BEGIN
    :NEW.TIME_STAMP := systimestamp;
END;

ALTER TABLE AM_SUBSCRIPTION ADD TIER_ID_PENDING VARCHAR2(50) /

ALTER TABLE AM_POLICY_SUBSCRIPTION ADD (
    MAX_COMPLEXITY DEFAULT O NOT NULL,
    MAX_DEPTH DEFAULT 0 NOT NULL,
)
/

CREATE TABLE IF NOT EXISTS AM_API_RESOURCE_SCOPE_MAPPING (
    SCOPE_NAME VARCHAR(255) NOT NULL,
    URL_MAPPING_ID INTEGER NOT NULL,
    TENANT_ID INTEGER NOT NULL,
    FOREIGN KEY (URL_MAPPING_ID) REFERENCES   AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
    PRIMARY KEY(SCOPE_NAME, URL_MAPPING_ID)
) /


CREATE TABLE IF NOT EXISTS AM_SHARED_SCOPE (
     NAME VARCHAR(255),
     UUID VARCHAR (256),
     TENANT_ID INTEGER,
     PRIMARY KEY (UUID)
) /

ALTER TABLE IDN_OAUTH2_RESOURCE_SCOPE DROP PRIMARY KEY /

CREATE TABLE AM_KEY_MANAGER (
  UUID VARCHAR(50) NOT NULL,
  NAME VARCHAR(100) NULL,
  DISPLAY_NAME VARCHAR(100) NULL,
  DESCRIPTION VARCHAR(256) NULL,
  TYPE VARCHAR(45) NULL,
  CONFIGURATION BLOB NULL,
  ENABLED CHAR(1) DEFAULT 1,
  TENANT_DOMAIN VARCHAR(100) NULL,
  PRIMARY KEY (UUID),
  UNIQUE (NAME,TENANT_DOMAIN)
)
 /

CREATE TABLE AM_TENANT_THEMES (
  TENANT_ID INTEGER NOT NULL,
  THEME BLOB NOT NULL,
  PRIMARY KEY (TENANT_ID)
)
/

CREATE TABLE AM_GRAPHQL_COMPLEXITY (
    UUID VARCHAR(256),
    API_ID INTEGER NOT NULL,
    TYPE VARCHAR(256),
    FIELD VARCHAR(256),
    COMPLEXITY_VALUE INTEGER,
    FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
    PRIMARY KEY(UUID),
    UNIQUE (API_ID,TYPE,FIELD)
)
/

UPDATE IDN_OAUTH_CONSUMER_APPS SET CALLBACK_URL="" WHERE CALLBACK_URL IS NULL /
