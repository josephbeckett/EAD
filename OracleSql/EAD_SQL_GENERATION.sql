--------------------------------------------------------------
-- Database creation Script

-- Auto-Generated by QSEE-SuperLite (c) 2001-2004 QSEE-Technologies Ltd.

-- Verbose generation: ON

-- note: spaces within table/column names have been replaced by underscores (_)

-- Target DB: ORACLE Version: 8

-- Entity Model :Entity Relationship Diagram

-- To drop the tables generated by this script run -
--   'C:\Users\josep\Desktop\Other Shit\NEW SQL EAD\EAD_SQL_GENERATION_drop.sql'

--------------------------------------------------------------



--------------------------------------------------------------
-- Table Creation --

-- Each entity on the model is represented by a table that needs to be created within the Database.
-- Within SQL new tables are created using the CREATE TABLE command.
-- When a table is created its name and its attributes are defined.
-- The values of which are derived from those specified on the model.
-- Certain constraints are sometimes also specified, such as identification of primary keys.

-- Create a Database table to represent the "projectTeamMembers" entity.
CREATE TABLE projectTeamMembers(
	projectTeamMembersID	INTEGER NOT NULL,
	fk1_employeeroleID	INTEGER NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "projectTeamMembers".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_projectTeamMembers PRIMARY KEY (projectTeamMembersID)
);

-- Create a Database table to represent the "project" entity.
CREATE TABLE project(
	projectID	INTEGER NOT NULL,
	projectName	VARCHAR2(50),
	Beginning	DATE,
	deadline	DATE,
	billableHours	INTEGER,
	fk1_clientID	INTEGER NOT NULL,
	fk2_employeeroleID	INTEGER NOT NULL,
	-- fk3_archiveID	INTEGER NOT NULL,
	-- -- Specify FK as unique to maintain 1:1 relationship
	-- UNIQUE(fk3_archiveID),
	-- Specify the PRIMARY KEY constraint for table "project".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_project PRIMARY KEY (projectID)
);

-- Create a Database table to represent the "client" entity.
CREATE TABLE client(
	clientID	INTEGER NOT NULL,
	companyName	VARCHAR2(100),
	Address	VARCHAR2(255),
	Email	VARCHAR2(100),
	phoneNum	VARCHAR2(15),
	-- Specify the PRIMARY KEY constraint for table "client".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_client PRIMARY KEY (clientID)
);

-- Create a Database table to represent the "employee" entity.
CREATE TABLE employee(
	employeeID	INTEGER NOT NULL,
	firstName	VARCHAR2(50),
	surname	VARCHAR2(50),
	address	VARCHAR2(255),
	homePhoneNum	VARCHAR2(15),
	workPhoneNum	VARCHAR2(15),
	email	VARCHAR2(100),
	startDate	DATE,
	leaveDate	DATE,
	Contract	VARCHAR2(50),
	skillLevel	INTEGER,
	-- Specify the PRIMARY KEY constraint for table "employee".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_employee PRIMARY KEY (employeeID)
);

-- Create a Database table to represent the "contacts" entity.
CREATE TABLE contacts(
	contactID	INTEGER NOT NULL,
	firstName	VARCHAR2(50),
	surname	VARCHAR2(50),
	phoneNum	VARCHAR2(15),
	email VARCHAR2(255),
	fk1_clientID	INTEGER NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "contacts".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_contacts PRIMARY KEY (contactID)
);

-- Create a Database table to represent the "projectActivities" entity.
CREATE TABLE projectActivities(
	projectActivitiesID	INTEGER NOT NULL,
	taskDescription	CLOB,
	taskDuration	INTEGER,
	fk1_projectTeamMembersID	INTEGER NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "projectActivities".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_projectActivities PRIMARY KEY (projectActivitiesID)
);

-- Create a Database table to represent the "payments" entity.
CREATE TABLE payments(
	paymentID	INTEGER NOT NULL,
	calculatedBill	INTEGER,
	paymentDueDate	DATE,
	paid	SMALLINT,
	fk1_projectID	INTEGER NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "payments".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_payments PRIMARY KEY (paymentID)
);

-- Create a Database table to represent the "projectTeam_project" entity.
CREATE TABLE projectTeam_project(
	teamProjectID	INTEGER NOT NULL,
	dateAdded	DATE,
	fk1_projectTeamMembersID	INTEGER NOT NULL,
	fk2_projectID	INTEGER NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "projectTeam_project".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_projectTeam_project PRIMARY KEY (teamProjectID)
);

-- Create a Database table to represent the "projectHours" entity.
CREATE TABLE projectHours(
	projectHoursID	INTEGER NOT NULL,
	hoursSpent	INTEGER,
	entryDate	DATE,
	fk1_projectTeamMembersID	INTEGER NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "projectHours".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_projectHours PRIMARY KEY (projectHoursID)
);

-- Create a Database table to represent the "roles" entity.
CREATE TABLE roles(
	roleID	INTEGER NOT NULL,
	roleDescription	CLOB,
	rolePay	DECIMAL(8,2),
	-- Specify the PRIMARY KEY constraint for table "roles".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_roles PRIMARY KEY (roleID)
);

-- Create a Database table to represent the "employeeRoles" entity.
CREATE TABLE employeeRoles(
	employeeroleID	INTEGER NOT NULL,
	roleChangedDate	DATE,
	fk1_employeeID	INTEGER NOT NULL,
	fk2_roleID	INTEGER NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "employeeRoles".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_employeeRoles PRIMARY KEY (employeeroleID)
);

-- Create a Database table to represent the "projectArchive" entity.
-- CREATE TABLE projectArchive(
-- 	archiveID	INTEGER NOT NULL,
-- 	projectName	VARCHAR2(50),
-- 	Beginning	DATE,
-- 	deadline	DATE,
-- 	billableHours	INTEGER,
-- 	datePaid	INTEGER,
-- 	comments	CLOB,
-- 	projectID	INTEGER,
-- 	projectTeamMembersID	INTEGER,
-- 	dateAdded	DATE,
-- 	-- Specify the PRIMARY KEY constraint for table "projectArchive".
-- 	-- This indicates which attribute(s) uniquely identify each row of data.
-- 	CONSTRAINT	pk_projectArchive PRIMARY KEY (archiveID)
-- );


--------------------------------------------------------------
-- Create LINK tables --

-- These tables do not appear as entities on the model. The reason they are created
-- is to allow certain types of relationships to be implemented in a Relational type Database.
-- Each link table tends to represent a specific relationship that appears on the model.
-- The attributes contained in link tables are identified from the entities at either side
-- of the relationship. i.e. they do not define attributes in their own right.
-- Indeed foreign key constraints are always created to ensure referential integrity between the
-- link table attributes and the primary key attributes on which they are based.

-- Create a link table to represent the "project_contacts" relationship.
-- The attributes of this table are taken from the primary keys of table "project" and
-- table "contacts", i.e. each end of the relationship. A link table was created
-- because "project_contacts" is a many to many relationship which required resolving.
-- notice how the primary key is a combination of the keys from both related tables (project and contacts).
CREATE TABLE project_contacts(
	s_projectID	INTEGER NOT NULL,
	d_contactID	INTEGER NOT NULL,
	dateContacted Date,
	PRIMARY KEY (s_projectID,d_contactID),
	FOREIGN KEY(s_projectID) REFERENCES project(projectID) ,
	FOREIGN KEY(d_contactID) REFERENCES contacts(contactID) 
);


--------------------------------------------------------------
-- Alter Tables to add fk constraints --

-- Now all the tables have been created the ALTER TABLE command is used to define some additional
-- constraints.  These typically constrain values of foreign keys to be associated in some way
-- with the primary keys of related tables.  Foreign key constraints can actually be specified
-- when each table is created, but doing so can lead to dependency problems within the script
-- i.e. tables may be referenced before they have been created.  This method is therefore safer.

-- Alter table to add new constraints required to implement the "c-p" relationship

-- This constraint ensures that the foreign key of table "project"
-- correctly references the primary key of table "client"

ALTER TABLE project
ADD (
	CONSTRAINT fk1_pro_to_client FOREIGN KEY(fk1_clientID) REFERENCES client(clientID) 
);

-- Alter table to add new constraints required to implement the "cli-cont" relationship

-- This constraint ensures that the foreign key of table "contacts"
-- correctly references the primary key of table "client"

ALTER TABLE contacts
ADD (
	CONSTRAINT fk1_contacts_to_client FOREIGN KEY(fk1_clientID) REFERENCES client(clientID) 
);

-- Alter table to add new constraints required to implement the "proteam-pat" relationship

-- This constraint ensures that the foreign key of table "projectActivities"
-- correctly references the primary key of table "projectTeamMembers"

ALTER TABLE projectActivities
ADD (
	CONSTRAINT fk1_proActiv_to_proTeamMem FOREIGN KEY(fk1_projectTeamMembersID) REFERENCES projectTeamMembers(projectTeamMembersID) 
);

-- Alter table to add new constraints required to implement the "proteam-pro" relationship

-- This constraint ensures that the foreign key of table "projectTeam_project"
-- correctly references the primary key of table "projectTeamMembers"

ALTER TABLE projectTeam_project
ADD (
	CONSTRAINT fk1_proTeam_pro_to_proTeamMem FOREIGN KEY(fk1_projectTeamMembersID) REFERENCES projectTeamMembers(projectTeamMembersID) 
);

-- Alter table to add new constraints required to implement the "pro-proteam" relationship

-- This constraint ensures that the foreign key of table "projectTeam_project"
-- correctly references the primary key of table "project"

ALTER TABLE projectTeam_project
ADD (
	CONSTRAINT fk2_proTeam_pro_to_pro FOREIGN KEY(fk2_projectID) REFERENCES project(projectID) 
);

-- Alter table to add new constraints required to implement the "projectHours_projectTeam_project" relationship

-- This constraint ensures that the foreign key of table "projectHours"
-- correctly references the primary key of table "projectTeam_project"

ALTER TABLE projectHours
ADD (
	CONSTRAINT fk1_proHours_to_proTeamMem FOREIGN KEY(fk1_projectTeamMembersID) REFERENCES projectTeamMembers(projectTeamMembersID) 
);

-- Alter table to add new constraints required to implement the "employeeRoles_employee" relationship

-- This constraint ensures that the foreign key of table "employeeRoles"
-- correctly references the primary key of table "employee"

ALTER TABLE employeeRoles
ADD (
	CONSTRAINT fk1_empRoles_to_employee FOREIGN KEY(fk1_employeeID) REFERENCES employee(employeeID) 
);

-- Alter table to add new constraints required to implement the "employeeRoles_roles" relationship

-- This constraint ensures that the foreign key of table "employeeRoles"
-- correctly references the primary key of table "roles"

ALTER TABLE employeeRoles
ADD (
	CONSTRAINT fk2_empRoles_to_roles FOREIGN KEY(fk2_roleID) REFERENCES roles(roleID) 
);

-- Alter table to add new constraints required to implement the "projectTeamMembers_employeeRoles" relationship

-- This constraint ensures that the foreign key of table "projectTeamMembers"
-- correctly references the primary key of table "employeeRoles"

ALTER TABLE projectTeamMembers
ADD (
	CONSTRAINT fk1_proTeamMem_to_empRoles FOREIGN KEY(fk1_employeeroleID) REFERENCES employeeRoles(employeeroleID) 
);

-- Alter table to add new constraints required to implement the "payments_project" relationship

-- This constraint ensures that the foreign key of table "payments"
-- correctly references the primary key of table "project"

ALTER TABLE payments
ADD (
	CONSTRAINT fk1_payments_to_project FOREIGN KEY(fk1_projectID) REFERENCES project(projectID) 
);

-- Alter table to add new constraints required to implement the "project_employeeRoles" relationship

-- This constraint ensures that the foreign key of table "project"
-- correctly references the primary key of table "employeeRoles"

ALTER TABLE project
ADD (
	CONSTRAINT fk2_pro_to_empRoles FOREIGN KEY(fk2_employeeroleID) REFERENCES employeeRoles(employeeroleID) 
);

-- Alter table to add new constraints required to implement the "project_projectArchive" relationship

-- This constraint ensures that the foreign key of table "project"
-- correctly references the primary key of table "projectArchive"

-- ALTER TABLE project
-- ADD (
-- 	CONSTRAINT fk3_pro_to_proArchive FOREIGN KEY(fk3_archiveID) REFERENCES projectArchive(archiveID) 
-- );


--------------------------------------------------------------
-- End of DDL file auto-generation
--------------------------------------------------------------

-- Insert Clients data into the database -- 
INSERT INTO client VALUES ('1', 'Red Tyres Ltd', '7 Industry Road Amington Tamworth B36 7EG', 'Red.Tyres@mail.com', '901335975');
INSERT INTO client VALUES ('2', 'TechPartners Ltd', '94 Industy Road Amington Tamworth F85 2BQ', 'Tech.Partners@mail.com', '743652650');
INSERT INTO client VALUES ('3','RobustEngineering Ltd','13 Industry Road Amington Tamworth B36 8GN','Robust.Engineering@Mail.com','7701316240');

--Insert Contacts data into the database --
INSERT INTO contacts VALUES ('1', 'Mike', 'Turner', '03439285787', 'Mike.Turner@Mail.com', '1');
INSERT INTO contacts VALUES ('2', 'Stacey', 'Cole', '03216743678', 'Stacey.Cove@Mail.com', '1');
INSERT INTO contacts VALUES ('3', 'Lucy', 'Bone', '01871245155', 'Lucy.Bone@Mail.com', '2');
INSERT INTO contacts VALUES ('4', 'Chloe', 'Thorn', '01247850634', 'Chloe.Thorn@Mail.com', '2');
INSERT INTO contacts VALUES ('5', 'Kyle', 'Crane', '03027496023', 'KyleCrane@hotmail.com', '3');
INSERT INTO contacts VALUES ('6', 'Roy', 'Marsh', '01214960968', 'RoyMarsh@gmail.com', '3');

-- Insert Role Data into the table --
INSERT INTO roles VALUES ('1', 'Manager', '50');
INSERT INTO roles VALUES ('2', 'Expert', '40');
INSERT INTO roles VALUES ('3', 'Intermediate', '15');
INSERT INTO roles VALUES ('4', 'National Minimum', '8.72');

-- Insert Employee Data into the database --
INSERT INTO employee VALUES ('1', 'David', 'Steiner', '4 new Drive Amington Tamworth B77 4EJ', '011474960053', '017924960739', 'David.Steiner@Mail.com', '2016-02-24', '', 'Part-Time', '2');
INSERT INTO employee VALUES ('2', 'Chris', 'Gordon', '2 Liverpool Street Trentham Stoke A37 4BT', '01214960591', '012544960892', 'Chris.Gordon@Mail.com', '2018-11-12', '','Full-Time', '3');
INSERT INTO employee VALUES ('3', 'Holly', 'Jones', '35 Bishopthorpe Road Penn Stoke ST1 1EN', '07004377321', '07962196398', 'Holly.Jones@Mail.com', '2019-07-17', '', 'Full-Time', '3');
INSERT INTO employee VALUES ('4', 'Jodie', 'Frost', '7 Lichfield Street Gillway Tamworth B79 4RV', '091394960126', '020574960251', 'Jodie.Frost@Mail.com', '2019-04-02', '', 'Full-Time', '2');
INSERT INTO employee VALUES ('5', 'Charley', 'May', '8 Blue Way Streetly Lichfield F45 3HJ', '015824960007', '016194960152', 'Charlie.May@Mail.com', '2007-12-04', '', 'Part-Time', '3');
INSERT INTO employee VALUES ('6', 'Harlie', 'Jones', '19 Red Drive Amington Tamworth B77 3BY', '015824960928', '015194960515', 'Harley.Jones@Mail.com', '2013-03-15', '', 'Full-Time', '2');
INSERT INTO employee VALUES ('7', 'Ronald', 'Hoof', '98  Winethrough Road Crowley Pendock GL19 0YQ', '07962196398', '056374960039', 'Ronald.H@gmail.com', '2018-11-08', '', 'Part-Time', '3');
INSERT INTO employee VALUES ('8', 'Kyle', 'Newman', '6 Jester Street Longford Stafford ST16 1AE', '016034960807', '016194960284', 'KyleN@gmail.com', '2010-09-16', '', 'Full-Time', '2');
INSERT INTO employee VALUES ('9', 'Lisa', 'Stuart', '4 Green Drive Gillway Birmingham B15 1BB', '012024960237', '018654960771', 'Liz@hotmail.com', '2009-03-13', '', 'Part-Time', '3');
INSERT INTO employee VALUES ('10', 'William', 'Vaughan', '109 Blue Drive Poole Stafford ST17 8HX', '07947508042', '07072505700', 'Will.Vaughan@Mail.com', '2007-09-08', '', 'Full-Time', '2');
INSERT INTO employee VALUES ('11', 'Owen', 'Pritchard', '55 Union Terrace Papworth Tamworth B75 9NI', '07916369062', '07000641030', 'Owen.Pritchard@Mail.com', '2009-03-24', '', 'Part-Time', '2');
INSERT INTO employee VALUES ('12', 'Jem', 'Stone', '12 New Street Beacon Stoke C62 4GH', '01625035412', '016044960467', 'Jem.Stone459@Mail.com', '2005-05-19', '', 'Full-Time', '1');
INSERT INTO employee VALUES ('13', 'Joe', 'Green', '35 New Drive Gillway Tamworth B42 3IJ', '01458765241','01733496089', 'Joe.Green326@Mail.com', '2004-10-06', '', 'Full-Time', '1');
INSERT INTO employee VALUES ('14', 'George', 'Foster', '12 Old Street Amington Stafford C62 4GH', '01532152430','016044960467', 'george.foster4@Mail.com', '2006-08-25', '', 'Full-Time', '1');
INSERT INTO employee VALUES ('15', 'Sam', 'Fisher', '35 Spring Drive Dosthill Birmingham B42 3IJ', '01545985461', '017334960895', 'sam.fisher2@Mail.com', '2007-09-11', '', 'Full-Time', '1');

-- Insert Data into the EmployeeRoles table --
INSERT INTO employeeRoles VALUES ('1', '2017-06-24', '1','2');
INSERT INTO employeeRoles VALUES ('2', '2018-11-12', '2','3');
INSERT INTO employeeRoles VALUES ('3', '2019-07-17', '3','3');
INSERT INTO employeeRoles VALUES ('4', '2019-04-02', '4','2');
INSERT INTO employeeRoles VALUES ('5', '2007-12-04', '5','3');
INSERT INTO employeeRoles VALUES ('6', '2013-03-15', '6','2');
INSERT INTO employeeRoles VALUES ('7', '2018-11-08', '7','3');
INSERT INTO employeeRoles VALUES ('8', '2010-09-16', '8','2');
INSERT INTO employeeRoles VALUES ('9', '2009-03-13', '9','2');
INSERT INTO employeeRoles VALUES ('10', '2007-09-08', '10','2');
INSERT INTO employeeRoles VALUES ('11', '2009-03-24', '11','2');
INSERT INTO employeeRoles VALUES ('12', '2005-05-19', '12','1');
INSERT INTO employeeRoles VALUES ('13', '2004-10-06', '13','1');
INSERT INTO employeeRoles VALUES ('14', '2006-08-25', '14','1');
INSERT INTO employeeRoles VALUES ('15', '2007-09-11', '15','1');

-- Insert Project data into the project table --
INSERT INTO project VALUES ('1','Database Auditing','2020-04-12','2020-07-02', '40' , '1', '12');
INSERT INTO project VALUES ('2','Database Auditing','2020-03-24','2020-08-04', '60', '1', '12');
INSERT INTO project VALUES ('3','Starting Database','2020-02-24','2020-08-24', '70', '2', '12');
INSERT INTO project VALUES ('4','Database Auditing','2020-05-25','2020-07-29', '10', '3', '12');

-- Insert Project and Contact data into Project_contact linked table --
INSERT INTO project_contacts VALUES ('1','1', '2020-05-12');
INSERT INTO project_contacts VALUES ('2','2', '2020-04-18');
INSERT INTO project_contacts VALUES ('3','4', '2020-04-02');
INSERT INTO project_contacts VALUES ('4','5', '2020-03-27');

-- Insert Project Team Members data into database --
INSERT INTO projectTeamMembers VALUES ('1', '1');
INSERT INTO projectTeamMembers VALUES ('2', '2');
INSERT INTO projectTeamMembers VALUES ('3', '3');
INSERT INTO projectTeamMembers VALUES ('4', '4');
INSERT INTO projectTeamMembers VALUES ('5', '5');
INSERT INTO projectTeamMembers VALUES ('6', '6');
INSERT INTO projectTeamMembers VALUES ('7', '7');
INSERT INTO projectTeamMembers VALUES ('8', '8');
INSERT INTO projectTeamMembers VALUES ('9', '9');
INSERT INTO projectTeamMembers VALUES ('10', '10');
INSERT INTO projectTeamMembers VALUES ('11', '11');

-- Insert Project Activities data into the database --
INSERT INTO projectActivities VALUES ('1', 'Auditing', '4', '1');
INSERT INTO projectActivities VALUES ('2', 'Database Work', '6', '3');
INSERT INTO projectActivities VALUES ('3', 'Legislation', '8', '5');
INSERT INTO projectActivities VALUES ('4', 'Database work', '3', '7');
INSERT INTO projectActivities VALUES ('5', 'Auditing', '9', '2');

-- Insert project team and project data into linking table --
INSERT INTO projectTeam_project VALUES ('1', '2020-04-12 14:52:46', '1', '1');
INSERT INTO projectTeam_project VALUES ('2', '2020-03-24 10:22:45', '2', '2');
INSERT INTO projectTeam_project VALUES ('3', '2020-04-12 08:22:25', '3', '3');
INSERT INTO projectTeam_project VALUES ('4', '2020-03-24 10:28:15', '4', '4');
INSERT INTO projectTeam_project VALUES ('5', '2020-02-24 08:24:31', '5', '1');
INSERT INTO projectTeam_project VALUES ('6', '2020-05-25 15:52:23', '6', '2');
INSERT INTO projectTeam_project VALUES ('7', '2020-02-24 08:24:31', '7', '3');
INSERT INTO projectTeam_project VALUES ('8', '2020-05-25 15:57:43', '8', '4');