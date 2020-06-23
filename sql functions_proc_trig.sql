SELECT e.firstName, e.surname, e.skilllevel, er.rolechangeddate, r.roledescription 
FROM employee e 
INNER JOIN employeeroles er on er.fk1_employeeID = e.employeeID
INNER JOIN roles r ON er.fk2_roleID = r.roleID
WHERE skilllevel = 2;

SELECT r.rolepay, p.billablehours, e.skilllevel, p.projectid
FROM employee e 
INNER JOIN employeeroles er on er.fk1_employeeID = e.employeeID
INNER JOIN roles r ON er.fk2_roleID = r.roleID
INNER JOIN project p ON p.fk2_employeeroleid = er.employeeroleid
INNER JOIN projectTeam_project ptp ON ptp.fk2_projectid = p.projectid
INNER JOIN projectHours ph ON ph.fk1_teamprojectid = ptp.teamprojectid;

SELECT p.projectid, r.rolepay, emp.employeeid, emp.firstname, emp.surname, ptp.dateadded, er.rolechangeddate, ptm.projectteammembersid, ph.hoursspent
FROM project p 
INNER JOIN projectteam_project ptp ON ptp.fk2_projectid = p.projectid
INNER JOIN projectteammembers ptm ON ptm.projectteammembersid = ptp.fk1_projectteammembersid
INNER JOIN employeeroles er ON er.employeeroleid = ptm.fk1_employeeroleid
INNER JOIN projectHours ph ON ph.projecthoursid = ptm.projectteammembersid
INNER JOIN roles r ON r.roleid = er.fk2_roleid
INNER JOIN employee emp ON emp.employeeid = er.fk1_employeeid;