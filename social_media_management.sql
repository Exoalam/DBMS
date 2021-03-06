SET SERVEROUTPUT ON
DROP TABLE COMMENTS_LIKED;
DROP TABLE POSTS_HAVE;
DROP TABLE COMMENTS;
DROP TABLE SHARES;
DROP TABLE PHOTOS;
DROP TABLE POSTS_LIKED;
DROP TABLE POSTS;
DROP TABLE PAGE_LIKED;
DROP TABLE PAGES;
DROP TABLE FRIENDS;
DROP TABLE PERMISSIONS;
DROP TABLE ROLES;
DROP TABLE LOGINS;
DROP TABLE USERS;

-- TABLE CREATION

CREATE TABLE USERS(
    USER_ID NUMBER(10) NOT NULL,
    USERNAME VARCHAR2(20),
    USER_MOBILE NUMBER(11),
    USER_EMAIL VARCHAR2(50),
    USER_ADDRESS VARCHAR2(50),
    PRIMARY KEY(USER_ID)
);

CREATE TABLE LOGINS(
    LOGIN_ID NUMBER(10) NOT NULL,
    LOGIN_USERNAME VARCHAR2(20),
    USER_PASSWORD VARCHAR2(20),
    PRIMARY KEY(LOGIN_ID),
    FOREIGN KEY(LOGIN_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

CREATE TABLE ROLES (
    ROLE_ID NUMBER(10) NOT NULL,
    ROLE_NAME VARCHAR2(20),
    ROLE_DESC VARCHAR2(50),
    PRIMARY KEY(ROLE_ID),
    FOREIGN KEY(ROLE_ID) REFERENCES LOGINS(LOGIN_ID) ON DELETE CASCADE
);

CREATE TABLE PERMISSIONS (
    PER_ID NUMBER(10) NOT NULL,
    PER_NAME VARCHAR2(10),
    PER_MODULE VARCHAR2(5),
    PRIMARY KEY(PER_ID),
    FOREIGN KEY(PER_ID) REFERENCES ROLES(ROLE_ID) ON DELETE CASCADE
);

CREATE TABLE FRIENDS (
    FRIEND_ID NUMBER(10) NOT NULL,
    USER_ID NUMBER(10) NOT NULL,
    PRIMARY KEY (FRIEND_ID),
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

CREATE TABLE PAGES (
    PAGE_ID NUMBER(15) NOT NULL,
    PAGE_NAME VARCHAR2(30),
    PAGE_CONTENT VARCHAR2(50),
    PRIMARY KEY(PAGE_ID)
);

CREATE TABLE PAGE_LIKED (
    PAGE_ID NUMBER(15) NOT NULL,
    USER_ID NUMBER(10) NOT NULL,
    PRIMARY KEY(PAGE_ID),
    FOREIGN KEY(PAGE_ID) REFERENCES PAGES(PAGE_ID) ON DELETE CASCADE,
    FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

CREATE TABLE POSTS (
    POST_ID NUMBER(12) NOT NULL,
    POST_CONTENT VARCHAR2(50),
    POST_DATE DATE,
    USER_ID NUMBER(10) NOT NULL,
    PRIMARY KEY(POST_ID),
    FOREIGN KEY(USER_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE
);

CREATE TABLE POSTS_LIKED (
    POST_ID NUMBER(12) NOT NULL,
    USER_ID NUMBER(10),
    PRIMARY KEY(POST_ID),
    FOREIGN KEY(POST_ID) REFERENCES POSTS(POST_ID) ON DELETE CASCADE
);

CREATE TABLE PHOTOS (
    PHOTO_ID NUMBER(8) NOT NULL,
    IMAGE_CONTENT VARCHAR2(64),
    POST_ID NUMBER(12) NOT NULL,
    PRIMARY KEY(PHOTO_ID)
);

CREATE TABLE SHARES (
    POST_ID NUMBER(12) NOT NULL,
    USER_ID NUMBER(10) NOT NULL,
    PRIMARY KEY(POST_ID),
    FOREIGN KEY(POST_ID) REFERENCES POSTS(POST_ID) ON DELETE CASCADE
);

CREATE TABLE COMMENTS (
    COMMENT_ID NUMBER(10) NOT NULL,
    USER_ID NUMBER(10) NOT NULL,
    POST_ID NUMBER(12) NOT NULL,
    COMMENT_DATE DATE,
    COMMENT_CONTENT VARCHAR2(50),
    PRIMARY KEY(COMMENT_ID),
    FOREIGN KEY(POST_ID) REFERENCES POSTS(POST_ID) ON DELETE CASCADE
);

CREATE TABLE POSTS_HAVE (
    POST_ID NUMBER(12) NOT NULL,
    PHOTO_ID NUMBER(8) NOT NULL,
    PRIMARY KEY(POST_ID, PHOTO_ID),
    FOREIGN KEY(POST_ID) REFERENCES POSTS(POST_ID) ON DELETE CASCADE, 
    FOREIGN KEY(PHOTO_ID) REFERENCES PHOTOS(PHOTO_ID) ON DELETE CASCADE
);

CREATE TABLE COMMENTS_LIKED (
    COMMENT_ID NUMBER(10) NOT NULL,
    USER_ID NUMBER(10) NOT NULL,
    PRIMARY KEY(COMMENT_ID),
    FOREIGN KEY(COMMENT_ID) REFERENCES COMMENTS(COMMENT_ID) ON DELETE CASCADE
);

ALTER TABLE USERS 
            ADD (
                STIME TIMESTAMP
            );            


-- TRIGGER
CREATE OR REPLACE TRIGGER ADD_DATA BEFORE INSERT OR UPDATE ON USERS
FOR EACH ROW
DECLARE
   TEMP TIMESTAMP;
BEGIN   
   SELECT SYSTIMESTAMP INTO TEMP FROM DUAL;
   :NEW.STIME := TEMP;
END;
/ 

-- DATA INSERTION TO TABLE

INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102001, 'NAFIUL ALAM', 01307232605, 'nafiul.arpon@gmail.com', 'BOGURA');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102002, 'HUMAIYON RUPOK', 01007232601, 'rupok@gmail.com', 'PABNA');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102003, 'PARTHO SHOMMO', 01007232602, 'shommo@gmail.com', 'SYLHET');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102004, 'KAZI FIYAZ', 01007232603, 'fiyaz@gmail.com', 'THAKURGA');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102005, 'RAIHAN IFTEE', 01007232604, 'iftee@gmail.com', 'JOYPURHAT');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102006, 'PRITHUL BISWAS', 01007232605, 'prithul@gmail.com', 'DHAKA');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102007, 'SUMAIYA MIFRA', 01007232606, 'mifra@gmail.com', 'DINAJPUR');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102008, 'ANZUM ISHA', 01007232607, 'isha@gmail.com', 'CHITTAGONG');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102009, 'TAQIUL ISLAM', 01007232608, 'taqiul@gmail.com', 'RAJSHAHI');
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102010, 'SHIHAB NEWAZ', 01007232609, 'shihab@gmail.com', 'BOGURA');

INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102001, 'NAFIUL', 'V12345678');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102002, 'RUPOK', '010072DSA5');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102003, 'SHOMMO', '010072AA02');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102004, 'FIYAZ', '01TT723203');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102005, 'IFTEE', '01XXSA7259604');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102006, 'PRITHUL', '0PRI832605');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102007, 'MIFRA', '010070A0606');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102008, 'ISHA', '01007255XX07');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102009, 'TAQIUL', '01005326TQ08');
INSERT INTO LOGINS (LOGIN_ID, LOGIN_USERNAME, USER_PASSWORD) VALUES (102010, 'SHIHAB', 'SH0100232609');

INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102001, 'ADMIN', 'DBMS ADMIN');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102002, 'NORMAL USER', 'USER WITH BASIC PLAN');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102003, 'PREMIUM USER', 'USER WITH PREMIUM PLAN');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102004, 'VIP USER', 'PREMIUM USER WITH SPECIAL PRIVILEGES');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102005, 'PREMIUM USER', 'USER WITH PREMIUM PLAN');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102006, 'MODERATOR', 'HANDLES POSTS');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102007, 'MODERATOR', 'HANDLES COMMENTS AND SHARES');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102008, 'VIP USER', 'PREMIUM USER WITH SPECIAL PRIVILEGES');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102009, 'MODERATOR', 'HANDLES PHOTOS');
INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102010, 'NORMAL USER', 'USER WITH BASIC PLAN');

INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102001, 'FULL', 'F-W/R');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102002, 'VIEWER', 'V');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102003, 'PVIEWER', 'P-V');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102004, 'SVIEWER', 'S-V');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102005, 'PVIEWER', 'P-V');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102006, 'SELECTIVE', 'S-W/R');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102007, 'SELECTIVE', 'S-W/R');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102008, 'SVIEWER', 'S-V');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102009, 'SELECTIVE', 'S-W/R');
INSERT INTO PERMISSIONS (PER_ID, PER_NAME, PER_MODULE) VALUES (102010, 'VIEWER', 'V');

INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102100, 102002);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102101, 102002);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102102, 102002);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102103, 102003);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102104, 102003);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102105, 102004);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102106, 102004);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102107, 102005);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102108, 102005);
INSERT INTO FRIENDS (FRIEND_ID, USER_ID) VALUES (102109, 102005);

INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300700, 'KUET CSE', 'DETAILS ABOUT KUET CSE');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300701, 'SGPCI', 'DETAILS ABOUT SGPCI');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300702, 'HACK', 'DETAILS ABOUT HARDWARE');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300703, 'KUET', 'DETAILS ABOUT KUET');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300704, 'BIT TO BYTE', 'DETAILS ABOUT B2B');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300705, 'SUC', 'DETAILS ABOUT SINGLE CLUB');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300706, 'FOODIES', 'DETAILS ABOUT FOODS');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300707, 'ADVENTURE CLUB', 'DETAILS ABOUT ADVENTURE CLUB');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300708, 'SOURCE OF PRODUCT', 'DETAILS ABOUT DIFFERENT PRODUCT');
INSERT INTO PAGES (PAGE_ID, PAGE_NAME, PAGE_CONTENT) VALUES (00300709, 'SHOMASH TECH', 'DETAILS ABOUT PHONES');

INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300700, 102002);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300701, 102002);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300702, 102002);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300703, 102002);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300704, 102002);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300705, 102003);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300706, 102003);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300707, 102003);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300708, 102003);
INSERT INTO PAGE_LIKED (PAGE_ID, USER_ID) VALUES (00300709, 102003);

INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000100, 'PATCH UPDATE', '01-JUN-2022', 102001);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000101, 'ADDED NEW PHOTO', '03-MAY-2022', 102002);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000102, 'CHANGED PROFILE NAME', '15-MAY-2022', 102002);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000103, 'SHARED NEW VIDEO', '02-JUN-2022', 102002);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000104, 'CHANGED PROFILE PHOTO', '05-APR-2022', 102003);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000105, 'SHARED A LINK', '30-APR-2022', 102003);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000106, 'ADDED NEW FPHOTOS', '15-JUN-2022', 102003);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000107, 'ADDED NEW RULES', '10-JUN-2022', 102006);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000108, 'REMOVED FEATURE', '11-MAY-2022', 102007);
INSERT INTO POSTS (POST_ID, POST_CONTENT, POST_DATE, USER_ID) VALUES (98000109, 'ADDED NEW PHOTO', '23-JUL-2022', 102009);

INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000100, 102101);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000101, 102102);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000102, 102103);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000103, 102103);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000104, 102104);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000105, 102104);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000106, 102102);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000107, 102106);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000108, 102106);
INSERT INTO POSTS_LIKED (POST_ID, USER_ID) VALUES (98000109, 102109);

INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556600, 'KSADBNFJKSNBDFJKADFSKNB', 98000100);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556601, 'ASKDJBJKASDBKJASDBJKADS', 98000101);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556602, 'AJKNSDIJABNSDJKNASDJNAS', 98000102);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556603, 'ASLDJKNIJASBHDJKASBNDAS', 98000103);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556604, 'KJNASDOIJEWIROPJKMASODK', 98000104);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556605, 'ALSKNDJKNARWJENKLNOAKLS', 98000105);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556606, 'AKSNDKLASNOEIDNOIWEMNOP', 98000106);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556607, 'ALKNDAOIWEJ0POMKCMPJPMM', 98000107);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556608, 'LNMASOKJNMDOIJAWO0PMLKA', 98000108);
INSERT INTO PHOTOS (PHOTO_ID, IMAGE_CONTENT, POST_ID) VALUES (556609, 'KAWJHNEOINAWEONONWALKNA', 98000109);

INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000100, 102101);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000101, 102102);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000102, 102103);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000103, 102103);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000104, 102104);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000105, 102104);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000106, 102102);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000107, 102106);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000108, 102106);
INSERT INTO SHARES (POST_ID, USER_ID) VALUES (98000109, 102109);

INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99000, 98000100, 102101);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99001, 98000101, 102102);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99002, 98000102, 102103);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99003, 98000103, 102103);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99004, 98000104, 102104);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99005, 98000105, 102104);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99006, 98000106, 102102);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99007, 98000107, 102106);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99008, 98000108, 102106);
INSERT INTO COMMENTS (COMMENT_ID, POST_ID, USER_ID) VALUES (99009, 98000109, 102109);

INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556600, 98000100);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556601, 98000101);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556602, 98000102);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556603, 98000103);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556604, 98000104);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556605, 98000105);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556606, 98000106);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556607, 98000107);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556608, 98000108);
INSERT INTO POSTS_HAVE (PHOTO_ID, POST_ID) VALUES (556609, 98000109);

INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99000, 102109);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99001, 102110);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99002, 102111);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99003, 102112);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99004, 102113);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99005, 102114);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99006, 102115);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99007, 102116);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99008, 102117);
INSERT INTO COMMENTS_LIKED (COMMENT_ID, USER_ID) VALUES (99009, 102118);

SELECT * FROM PHOTOS;

SELECT POST_ID, POST_CONTENT FROM POSTS;

ALTER TABLE POSTS_LIKED 
            ADD (
                REACTION VARCHAR2(10),
                TIME_LIKED TIMESTAMP
            );

DESCRIBE POSTS_LIKED;

ALTER TABLE POSTS_LIKED 
            MODIFY (
                REACTION NUMBER,
                TIME_LIKED TIMESTAMP
            );

DESCRIBE POSTS_LIKED;

ALTER TABLE POSTS_LIKED DROP COLUMN REACTION;

DESCRIBE POSTS_LIKED;

ALTER TABLE POSTS_LIKED RENAME COLUMN TIME_LIKED TO TIME_NOT_LIKED;

DESCRIBE POSTS_LIKED;

UPDATE COMMENTS_LIKED SET USER_ID = 999999 WHERE COMMENT_ID = 99009;

SELECT * FROM COMMENTS_LIKED;

DELETE FROM COMMENTS_LIKED WHERE COMMENT_ID = 99009;

SELECT * FROM COMMENTS_LIKED;

--FUNCTION

CREATE OR REPLACE FUNCTION SEARCH(ID USERS.USER_ID%TYPE)
RETURN USERS.USERNAME%TYPE
IS 
  SEARCHDATA USERS.USERNAME%TYPE;
BEGIN
  SELECT USERNAME INTO SEARCHDATA FROM USERS WHERE USER_ID = ID;
  RETURN SEARCHDATA;
END;   
/

BEGIN
 DBMS_OUTPUT.PUT_LINE(SEARCH(102010));
 END;
/

--PROCEDURE

CREATE OR REPLACE PROCEDURE ADMINSEARCH(ID USERS.USER_ID%TYPE)
IS 
  SEARCHNAME USERS.USERNAME%TYPE;
  SEARCHEMAIL USERS.USER_EMAIL%TYPE;
  SEARCHUNAME LOGINS.LOGIN_USERNAME%TYPE;
  SEARCHROLE ROLES.ROLE_NAME%TYPE;
BEGIN
  SELECT USERNAME INTO SEARCHNAME FROM USERS WHERE USER_ID = ID;
  SELECT USER_EMAIL INTO SEARCHEMAIL FROM USERS WHERE USER_ID = ID;
  SELECT LOGIN_USERNAME INTO SEARCHUNAME FROM LOGINS WHERE LOGIN_ID = ID;
  SELECT ROLE_NAME INTO SEARCHROLE FROM ROLES WHERE ROLE_ID = ID;
  DBMS_OUTPUT.PUT_LINE('FULL NAME: ' || SEARCHNAME || ' EMAIL: ' || SEARCHEMAIL || ' USERNAME: ' || SEARCHUNAME || ' ROLE: ' || SEARCHROLE);
END;   
/

BEGIN
 ADMINSEARCH(102005);
 END;
/

-- ON DELETE CASCADE

DELETE FROM USERS WHERE USER_ID = 102001;
SELECT * FROM LOGINS;
SELECT * FROM USERS;

-- TYPE IS, NESTED JOIN AND NESTED SQL SUING FUNCTION

CREATE OR REPLACE FUNCTION CHECK_AVAILABLE
RETURN USERS.USERNAME%TYPE 
IS 
 CAL USERS.USERNAME%TYPE;
 VALUE1 USERS.USERNAME%TYPE;
 VALUE2_1 USERS.USER_EMAIL%TYPE;
 VALUE2_2 LOGINS.LOGIN_USERNAME%TYPE;
 VALUE2_3 ROLES.ROLE_DESC%TYPE;
 VALUE2_4 PERMISSIONS.PER_MODULE%TYPE;
BEGIN
 SELECT USERNAME INTO VALUE1 FROM USERS WHERE USER_ID IN 
 (((SELECT ROLE_ID FROM ROLES WHERE ROLE_NAME = 'MODERATOR') INTERSECT (SELECT PER_ID FROM PERMISSIONS WHERE PER_NAME = 'SELECTIVE')) 
 INTERSECT (SELECT USER_ID FROM USERS WHERE USER_ADDRESS = 'RAJSHAHI'));
 SELECT USER_EMAIL, LOGIN_USERNAME, ROLE_DESC, PER_MODULE INTO VALUE2_1, VALUE2_2, VALUE2_3, VALUE2_4 FROM (SELECT * FROM (SELECT * FROM USERS JOIN LOGINS ON
  USERS.USER_ID = LOGINS.LOGIN_ID) TEMP JOIN ROLES ON 
  (TEMP.USER_ID = ROLES.ROLE_ID)) TEMP2 JOIN PERMISSIONS ON 
  (TEMP2.USER_ID = PERMISSIONS.PER_ID) WHERE USERNAME = VALUE1;
 DBMS_OUTPUT.PUT_LINE(VALUE2_1 || ' ' || VALUE2_2 || ' ' || VALUE2_3 || ' ' || VALUE2_4);
 RETURN 'DONE';
END;
/
SHOW ERRORS 

BEGIN
 DBMS_OUTPUT.PUT_LINE(CHECK_AVAILABLE);
END;
/ 

--CURSOR, NATURAL JOIN AND LIKE


DECLARE
   CURSOR POST_CURSOR IS SELECT * FROM POSTS NATURAL JOIN PHOTOS
    WHERE POST_CONTENT LIKE 'A__ED%';
   POST_DATA POST_CURSOR%ROWTYPE;

BEGIN
OPEN POST_CURSOR;
  LOOP
    FETCH POST_CURSOR INTO POST_DATA;
    EXIT WHEN POST_CURSOR%ROWCOUNT = 4;     
    DBMS_OUTPUT.PUT_LINE(POST_DATA.POST_ID || ' ' || POST_DATA.POST_CONTENT || ' ' || POST_DATA.POST_DATE || ' ' ||  POST_DATA.USER_ID);
  END LOOP; 
CLOSE POST_CURSOR;
END;
/ 

-- NESTED PL/SQL OUTER JOIN

DECLARE
BEGIN
  -- LEFT OUTER JOIN
  DECLARE
    CURSOR P_CUR IS SELECT USER_MOBILE FROM USERS LEFT OUTER JOIN FRIENDS ON USERS.USER_ID = FRIENDS.USER_ID;
    P_DATA P_CUR%ROWTYPE;
  BEGIN
    OPEN P_CUR;
    WHILE P_CUR%ROWCOUNT < 5
    LOOP
     FETCH P_CUR INTO P_DATA;
     DBMS_OUTPUT.PUT_LINE('LEFT OUTER JOIN' || P_DATA.USER_MOBILE);
    END LOOP; 
    CLOSE P_CUR;
  END;
  -- RIGHT OUTER JOIN
  DECLARE
    CURSOR P_CUR IS SELECT USER_MOBILE FROM USERS RIGHT OUTER JOIN FRIENDS ON USERS.USER_ID = FRIENDS.USER_ID;
    P_DATA P_CUR%ROWTYPE;
  BEGIN
    OPEN P_CUR;
    FETCH P_CUR INTO P_DATA;
    WHILE P_CUR%ROWCOUNT < 5
    LOOP
     FETCH P_CUR INTO P_DATA;
     DBMS_OUTPUT.PUT_LINE('RIGHT OUTER JOIN' || P_DATA.USER_MOBILE);
    END LOOP; 
    CLOSE P_CUR;
  END;
  -- FULL OUTER JOIN
  DECLARE
    CURSOR P_CUR IS SELECT USER_MOBILE FROM USERS FULL OUTER JOIN FRIENDS ON USERS.USER_ID = FRIENDS.USER_ID;
    P_DATA P_CUR%ROWTYPE;
  BEGIN
    OPEN P_CUR;
    FETCH P_CUR INTO P_DATA;
    WHILE P_CUR%ROWCOUNT < 5
    LOOP
     FETCH P_CUR INTO P_DATA;
     DBMS_OUTPUT.PUT_LINE('FULL OUTER JOIN' || P_DATA.USER_MOBILE);
    END LOOP; 
    CLOSE P_CUR;
  END;
END;
/     

-- AGGREGATE FUNCTIONS

SELECT COUNT(USERNAME), MAX(USER_ID), MIN(USER_ID) FROM USERS JOIN ROLES ON USER_ID = ROLE_ID WHERE ROLES.ROLE_NAME = 'MODERATOR';

SELECT ROLE_NAME, COUNT(USER_ID) FROM USERS JOIN ROLES ON USER_ID = ROLE_ID GROUP BY ROLE_NAME;  

SELECT ROLE_NAME, COUNT(USER_ID) FROM USERS JOIN ROLES ON USER_ID = ROLE_ID GROUP BY ROLE_NAME HAVING ROLE_NAME = 'MODERATOR'; 

SELECT USERNAME FROM USERS ORDER BY USER_ID DESC;

SELECT DISTINCT ROLE_NAME FROM ROLES;

-- TRANSACTION 

COMMIT;
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102011, 'TEMP', 01007235559, 'TEMP@gmail.com', 'XXXX');
SELECT * FROM USERS;
SELECT COUNT(*) FROM USERS;
ROLLBACK;
SELECT * FROM USERS;
SELECT COUNT(*) FROM USERS;

INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102012, 'TEMP1', 01007235559, 'TEMP1@gmail.com', 'XXXX1');
SELECT COUNT(*) FROM USERS;
SAVEPOINT X1;
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102013, 'TEMP2', 01007235559, 'TEMP2@gmail.com', 'XXXX2');
SELECT COUNT(*) FROM USERS;
INSERT INTO USERS (USER_ID, USERNAME, USER_MOBILE, USER_EMAIL, USER_ADDRESS) VALUES (102014, 'TEMP3', 01007235559, 'TEMP3@gmail.com', 'XXXX3');
SELECT COUNT(*) FROM USERS;
ROLLBACK TO X1;
SELECT COUNT(*) FROM USERS;

--TRIGGER

CREATE OR REPLACE TRIGGER CHECK_DATA BEFORE INSERT OR UPDATE ON ROLES
FOR EACH ROW
BEGIN   
   IF:NEW.ROLE_NAME = 'ADMIN' OR :NEW.ROLE_NAME = 'MODERATOR' THEN
   RAISE_APPLICATION_ERROR(-20000,'ADMIN OR MODERATOR CAN NOT BE CREATED');
   END IF;
   END;
   / 

INSERT INTO ROLES (ROLE_ID, ROLE_NAME, ROLE_DESC) VALUES (102011, 'MODERATOR', 'XXXX');

-- CROSS JOIN

SELECT * FROM USERS CROSS JOIN LOGINS;

-- USER INPUT

DECLARE
 DATA1 VARCHAR2(10);
BEGIN
 DATA1 := &VARCHAR2;
 DBMS_OUTPUT.PUT_LINE('VALUE: ' || DATA1);
END;
/
SHOW ERRORS  

-- VIEW

CREATE OR REPLACE VIEW XVIEW AS SELECT USERNAME, USER_ID, USER_ADDRESS FROM USERS WHERE USER_ID = 102005;

SELECT * FROM XVIEW;

--TO DATE

SELECT GREATEST (TO_DATE('13-FEB-1971'), TO_DATE('15-JUN-2010')) FROM DUAL;  

SELECT LEAST(STIME) FROM USERS;
