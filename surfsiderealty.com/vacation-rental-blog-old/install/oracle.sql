
CREATE TABLE TBLBLOGCATEGORIES
(
  CATEGORYID     VARCHAR2(35 BYTE)              NOT NULL,
  CATEGORYNAME   VARCHAR2(50 BYTE)              NOT NULL,
  CATEGORYALIAS  VARCHAR2(50 BYTE),
  BLOG           VARCHAR2(50 BYTE)
);


CREATE TABLE TBLBLOGCOMMENTS
(
  ID         VARCHAR2(35 BYTE)                  NOT NULL,
  ENTRYIDFK  VARCHAR2(35 BYTE),
  NAME       VARCHAR2(50 BYTE),
  EMAIL      VARCHAR2(50 BYTE),
  COMMENTS   CLOB,
  POSTED     DATE,
  SUBSCRIBE  INTEGER                            DEFAULT 0,
  MODERATED  INTEGER                            DEFAULT 0,  
  WEBSITE    VARCHAR2(255 BYTE),
  KILLCOMMENT  VARCHAR2(35 BYTE),
  SUBSCRIBEONLY INTEGER DEFAULT 0
);


CREATE TABLE TBLBLOGENTRIES
(
  ID             VARCHAR2(35 BYTE)              NOT NULL,
  TITLE          VARCHAR2(100 BYTE),
  BODY           CLOB,
  POSTED         DATE                           DEFAULT sysdate,
  MOREBODY       CLOB,
  ALIAS          VARCHAR2(100 BYTE),
  USERNAME       VARCHAR2(50 BYTE),
  BLOG           VARCHAR2(50 BYTE),
  ALLOWCOMMENTS  NUMBER(1)                      DEFAULT 0,
  ENCLOSURE      VARCHAR2(255 BYTE),
  FILESIZE       NUMBER(11),
  MIMETYPE       VARCHAR2(255 BYTE),
  VIEWS          NUMBER(11)                     DEFAULT 0,
  RELEASED       NUMBER(1)                      DEFAULT 0,
  MAILED         NUMBER(1)                      DEFAULT 0,
  SUMMARY          VARCHAR2(255 BYTE),
  SUBTITLE          VARCHAR2(100 BYTE),
  KEYWORDS          VARCHAR2(100 BYTE),
  DURATION          VARCHAR2(10 BYTE)
);


CREATE TABLE TBLBLOGENTRIESCATEGORIES
(
  CATEGORYIDFK  VARCHAR2(35 BYTE)               NOT NULL,
  ENTRYIDFK     VARCHAR2(35 BYTE)               NOT NULL
);


CREATE TABLE TBLBLOGENTRIESRELATED
(
  ID         NUMBER(11),
  ENTRYID    VARCHAR2(35 BYTE)                  NOT NULL,
  RELATEDID  VARCHAR2(35 BYTE)
);


CREATE TABLE TBLBLOGPAGES
(
  ID     VARCHAR2(35 BYTE)                      NOT NULL,
  TITLE  VARCHAR2(255 BYTE),
  ALIAS  VARCHAR2(100 BYTE),
  BODY   CLOB,
  BLOG   VARCHAR2(50 BYTE)
);


CREATE TABLE TBLBLOGSEARCHSTATS
(
  SEARCHTERM  VARCHAR2(255 BYTE),
  SEARCHED    DATE                              DEFAULT sysdate,
  BLOG        VARCHAR2(50 BYTE)
);


CREATE TABLE TBLBLOGSUBSCRIBERS
(
  EMAIL     VARCHAR2(50 BYTE),
  TOKEN     VARCHAR2(35 BYTE),
  BLOG      VARCHAR2(50 BYTE),
  VERIFIED  NUMBER(1)                           DEFAULT 0
);


CREATE TABLE TBLBLOGTEXTBLOCKS
(
  ID     VARCHAR2(35 BYTE)                      NOT NULL,
  LABEL  VARCHAR2(255 BYTE),
  BODY   CLOB,
  BLOG   VARCHAR2(50 BYTE)
);


CREATE TABLE TBLBLOGTRACKBACKS
(
  ID        VARCHAR2(35 BYTE)                   NOT NULL,
  TITLE     VARCHAR2(255 BYTE),
  BLOGNAME  VARCHAR2(255 BYTE),
  POSTURL   VARCHAR2(255 BYTE),
  EXCERPT   CLOB,
  CREATED   DATE                                DEFAULT sysdate,
  ENTRYID   VARCHAR2(35 BYTE),
  BLOG      VARCHAR2(50 BYTE)
);


CREATE TABLE TBLUSERS
(
  USERNAME  VARCHAR2(50 BYTE),
  PASSWORD  VARCHAR2(50 BYTE),
  NAME      VARCHAR2(50 BYTE)
);


CREATE UNIQUE INDEX PK_TBLBLOGCATEGORIES ON TBLBLOGCATEGORIES
(CATEGORYID);


CREATE UNIQUE INDEX PK_TBLBLOGCOMMENTS ON TBLBLOGCOMMENTS
(ID);


CREATE UNIQUE INDEX PK_TBLBLOGENTRIES ON TBLBLOGENTRIES
(ID);


CREATE UNIQUE INDEX PK_TBLBLOGENTRIESCATEGORIES ON TBLBLOGENTRIESCATEGORIES
(CATEGORYIDFK, ENTRYIDFK);


CREATE UNIQUE INDEX PK_TBLBLOGPAGES ON TBLBLOGPAGES
(ID);


CREATE UNIQUE INDEX PK_TBLBLOGTEXTBLOCKS ON TBLBLOGTEXTBLOCKS
(ID);


CREATE UNIQUE INDEX PK_TBLBLOGTRACKBACKS ON TBLBLOGTRACKBACKS
(ID);


ALTER TABLE TBLBLOGCATEGORIES ADD (
  CONSTRAINT PK_TBLBLOGCATEGORIES
 PRIMARY KEY
 (CATEGORYID));

ALTER TABLE TBLBLOGCOMMENTS ADD (
  CONSTRAINT PK_TBLBLOGCOMMENTS
 PRIMARY KEY
 (ID));

ALTER TABLE TBLBLOGENTRIES ADD (
  CONSTRAINT PK_TBLBLOGENTRIES
 PRIMARY KEY
 (ID));

ALTER TABLE TBLBLOGENTRIESCATEGORIES ADD (
  CONSTRAINT PK_TBLBLOGENTRIESCATEGORIES
 PRIMARY KEY
 (CATEGORYIDFK, ENTRYIDFK));

ALTER TABLE TBLBLOGPAGES ADD (
  CONSTRAINT PK_TBLBLOGPAGES
 PRIMARY KEY
 (ID));

ALTER TABLE TBLBLOGTEXTBLOCKS ADD (
  CONSTRAINT PK_TBLBLOGTEXTBLOCKS
 PRIMARY KEY
 (ID));

ALTER TABLE TBLBLOGTRACKBACKS ADD (
  CONSTRAINT PK_TBLBLOGTRACKBACKS
 PRIMARY KEY
 (ID));

 
insert into TBLUSERS (username, password, name)
values ('admin', 'admin', 'Admin');
 
GRANT DELETE ON  TBLBLOGCATEGORIES TO $yourschema;

GRANT DELETE ON  TBLBLOGCOMMENTS TO $yourschema;

GRANT DELETE ON  TBLBLOGENTRIESCATEGORIES TO $yourschema;

GRANT DELETE ON  TBLBLOGPAGES TO $yourschema;

GRANT DELETE ON  TBLBLOGSUBSCRIBERS TO $yourschema;

GRANT DELETE ON  TBLBLOGTRACKBACKS TO $yourschema;

GRANT DELETE ON  TBLUSERS TO $yourschema;

GRANT DELETE ON  TBLBLOGTEXTBLOCKS TO $yourschema;

GRANT DELETE ON  TBLBLOGSEARCHSTATS TO $yourschema;

GRANT DELETE ON  TBLBLOGENTRIESRELATED TO $yourschema;

GRANT DELETE ON  TBLBLOGENTRIES TO $yourschema;

GRANT INSERT ON  TBLBLOGCATEGORIES TO $yourschema;

GRANT INSERT ON  TBLUSERS TO $yourschema;

GRANT INSERT ON  TBLBLOGTRACKBACKS TO $yourschema;

GRANT INSERT ON  TBLBLOGTEXTBLOCKS TO $yourschema;

GRANT INSERT ON  TBLBLOGCOMMENTS TO $yourschema;

GRANT INSERT ON  TBLBLOGENTRIES TO $yourschema;

GRANT INSERT ON  TBLBLOGPAGES TO $yourschema;

GRANT INSERT ON  TBLBLOGSUBSCRIBERS TO $yourschema;

GRANT INSERT ON  TBLBLOGSEARCHSTATS TO $yourschema;

GRANT INSERT ON  TBLBLOGENTRIESRELATED TO $yourschema;

GRANT INSERT ON  TBLBLOGENTRIESCATEGORIES TO $yourschema;

GRANT SELECT ON  TBLBLOGCATEGORIES TO $yourschema;

GRANT SELECT ON  TBLUSERS TO $yourschema;

GRANT SELECT ON  TBLBLOGTRACKBACKS TO $yourschema;

GRANT SELECT ON  TBLBLOGTEXTBLOCKS TO $yourschema;

GRANT SELECT ON  TBLBLOGSUBSCRIBERS TO $yourschema;

GRANT SELECT ON  TBLBLOGSEARCHSTATS TO $yourschema;

GRANT SELECT ON  TBLBLOGPAGES TO $yourschema;

GRANT SELECT ON  TBLBLOGENTRIESRELATED TO $yourschema;

GRANT SELECT ON  TBLBLOGCOMMENTS TO $yourschema;

GRANT SELECT ON  TBLBLOGENTRIESCATEGORIES TO $yourschema;

GRANT SELECT ON  TBLBLOGENTRIES TO $yourschema;

GRANT UPDATE ON  TBLBLOGCATEGORIES TO $yourschema;

GRANT UPDATE ON  TBLUSERS TO $yourschema;

GRANT UPDATE ON  TBLBLOGTRACKBACKS TO $yourschema;

GRANT UPDATE ON  TBLBLOGTEXTBLOCKS TO $yourschema;

GRANT UPDATE ON  TBLBLOGCOMMENTS TO $yourschema;

GRANT UPDATE ON  TBLBLOGENTRIESCATEGORIES TO $yourschema;

GRANT UPDATE ON  TBLBLOGPAGES TO $yourschema;

GRANT UPDATE ON  TBLBLOGSUBSCRIBERS TO $yourschema;

GRANT UPDATE ON  TBLBLOGSEARCHSTATS TO $yourschema;

GRANT UPDATE ON  TBLBLOGENTRIESRELATED TO $yourschema;

GRANT UPDATE ON  TBLBLOGENTRIES TO $yourschema;


