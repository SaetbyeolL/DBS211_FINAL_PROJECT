--1
CREATE TABLE LOCATION(
locID               NUMBER(5) NOT NULL PRIMARY KEY,
locationDescription VARCHAR2(255),
sectionName         VARCHAR2(50)
);

--2
CREATE TABLE ANIMAL (
animalID           NUMBER(9,0) NOT NULL PRIMARY KEY,
animalType         VARCHAR2(255) NOT NULL,
animalName         VARCHAR2(255) NOT NULL,
animalDOB          DATE NOT NULL,
animalActivity     CHAR(1),
locationID         NUMBER(5,0) NOT NULL,     
medicalRecordNum   NUMBER(9,0) NOT NULL,
sex                CHAR(1),
logID              NUMBER(9,0) NOT NULL,

CONSTRAINT  animal_activity_ck CHECK (animalActivity = 'N' OR animalActivity = 'D'),
CONSTRAINT  animal_sex_ck CHECK (sex = 'F' OR sex = 'M' OR sex = 'H')  
); 
--2.1 add constraints
ALTER TABLE ANIMAL 
ADD CONSTRAINT fk_locationID
FOREIGN KEY (locationID) REFERENCES LOCATION (locID);

--3
CREATE TABLE ANIMAL_DAILY_LOG (
dailyLogId   NUMBER(9,0) NOT NULL PRIMARY KEY,
temperature  NUMBER(9,1),
humidity     NUMBER(9,1),
caretakerId  NUMBER(9,0),
logDate      DATE NOT NULL,
feedingNum   NUMBER(9,0)
);

-- 4
CREATE TABLE EMPLOYEE (   
employeeID     NUMBER(38,0) NOT NULL PRIMARY KEY,
employeeType   VARCHAR2(50) NOT NULL,
firstName      VARCHAR2(50) NOT NULL,
lastName       VARCHAR2(50) NOT NULL,
email          VARCHAR2(100) NOT NULL,
phoneNumber    VARCHAR2(50) NOT NULL,
city           VARCHAR2(50),
streetNumber   NUMBER(38,0),
streetName     VARCHAR2(50),
province       VARCHAR2(50),
postalCode     CHAR(6),
sinNumber      NUMBER(9,0)  NOT NULL
);

--5
CREATE TABLE VACCINATION_EVENT (
vacRecordNum NUMBER (9,0) PRIMARY KEY,
animalID     NUMBER (9,0) NOT NULL,
eventDate    DATE NOT NULL
);

--5.1 add constraint primary keys
ALTER TABLE VACCINATION_EVENT 
ADD CONSTRAINT pk_vaccination_event PRIMARY KEY (vacRecordNum, animalID);


--6
CREATE TABLE MEDICAL_EVENT (
medRecordNum    NUMBER (9,0) PRIMARY KEY, 
med_animalID    NUMBER (9,0) NOT NULL,
eventDate       DATE NOT NULL,
eventType       VARCHAR2 (50)
);

--6.1 add primary keys
ALTER TABLE MEDICAL_EVENT 
ADD CONSTRAINT pk_medical_event PRIMARY KEY (medRecordNum, med_animalID); 

--7
CREATE TABLE MEDICAL_RECORD (
medicalRecordNumber NUMBER(9,0) PRIMARY KEY,
medicalType         VARCHAR2(255) NOT NULL,
medicationDosage    NUMBER(3,0) NOT NULL, 
vetID               NUMBER(9,0) NOT NULL,                     
accidentType        VARCHAR2(255) NOT NULL,
treatment           VARCHAR2(255) NOT NULL
);

--8
CREATE TABLE VACCINATION_RECORD (
vacRecordNum        NUMBER(9,0) PRIMARY KEY,
vac_vetID           NUMBER(9,0) NOT NULL,
vacType             VARCHAR2(255) NOT NULL,
vacDosage           NUMBER(4,0) NOT NULL
);

--8.1
ALTER TABLE VACCINATION_RECORD
ADD CONSTRAINT fk_vac_vetID 
FOREIGN KEY (vac_vetID) REFERENCES EMPLOYEE (employeeID);

--add the rest of the constrainst
ALTER TABLE VACCINATION_EVENT
ADD CONSTRAINT fk_animalID 
FOREIGN KEY (animalID) REFERENCES ANIMAL (animalID);


ALTER TABLE VACCINATION_EVENT
ADD CONSTRAINT fk_vacRecordNum
FOREIGN KEY (vacRecordNum) REFERENCES VACCINATION_RECORD (vacRecordNum);


ALTER TABLE ANIMAL_DAILY_LOG
ADD CONSTRAINT fk_caretakerId
FOREIGN KEY (caretakerId) REFERENCES EMPLOYEE (employeeID);

ALTER TABLE MEDICAL_EVENT
ADD CONSTRAINT fk_medRecordNum
FOREIGN KEY (medRecordNum) 
REFERENCES medical_record (medicalRecordNumber);

ALTER TABLE MEDICAL_EVENT
ADD CONSTRAINT fk_med_animalID
FOREIGN KEY (med_animalID) 
REFERENCES animal (animalID);

ALTER TABLE MEDICAL_RECORD
ADD CONSTRAINT fk_vetID
FOREIGN KEY (vetID) REFERENCES EMPLOYEE (employeeID);
