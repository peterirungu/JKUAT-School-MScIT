--------------------------------------------------------------------------------
--
-- Sql Command File For Creating And Populating The Property-
-- System Database.-  For use with UNIT 1 - SQL Guide version 1
--
-- Written By: Sue Stirk                                                 -
-- Jan 2002                                                               -
-------------------------------------------------------------------------------
drop table lease
/
drop table viewing
/
drop table tenant
/
drop table inspection
/
drop table prop_for_rent
/
drop table prop_type
/
drop table owner
/
drop table staff
/
drop table branch
/
create table branch
(branch_no number(3) not null primary key,
br_street varchar2(25) not null,
br_area varchar2(20),
br_town varchar2(20) not null,
br_pcode varchar2(8) not null,
br_telno varchar2(12))
/
create table staff
(staff_no number(5) primary key,
branch_no number(3) references branch(branch_no),
staff_surname varchar2(25) not null,
staff_forenames varchar2(25) not null,
staff_street varchar2(25) not null,
staff_area varchar2(20),
staff_town varchar2(20) not null,
staff_pcode varchar2(8) not null,
staff_telno varchar2(12),
staff_gender varchar2(1),
staff_salary number (8,2))
/

create table owner
(owner_no number(5) not null primary key,
ow_surname varchar2(25) not null,
ow_forenames varchar2(25) not null,
ow_street varchar2(25) not null,
ow_area varchar2(20),
ow_town varchar2(20) not null,
ow_pcode varchar2(8) not null,
ow_fee number(6,2))
/
create table prop_for_rent
(property_no number(5) not null primary key,
prop_street varchar2(25) not null,
prop_area varchar2(20),
prop_town varchar2(20) not null,
prop_pcode varchar2(8) not null,
prop_type varchar2(1) not null,
prop_rooms number(2) not null,
prop_rent_pm number(7,2) not null,
prop_poll_tax number(6,2),
owner_no number(5) not null references owner(owner_no),
staff_no number(5) references staff(staff_no), 
branch_no number(3) not null references branch(branch_no),
available varchar2(1),
comments varchar2(150))
/
create table prop_type
(prop_type varchar2(1) not null,
type_desc varchar2(15) not null)
/
create table tenant
(tenant_no number(5) not null primary key,
t_surname varchar2(25) not null,
t_forenames varchar2(25) not null,
t_street varchar2(25) not null,
t_area varchar2(20),
t_town varchar2(20) not null,
t_postcode varchar2(8) not null,
t_telno varchar2(12),
t_pref_type varchar2(1),
t_max_rent number(6,2))
/
create table lease
(lease_no number(5) not null primary key,
property_no number(5) not null references prop_for_rent(property_no),
tenant_no number(5) not null references tenant(tenant_no),
rent_pm number(6,2),
payment_method varchar2(1) not null,
deposit_amount number(6,2),
deposit_paid varchar2(1),
stdate date not null,
enddate date)
/
create table viewing
(property_no number(5) not null references prop_for_rent(property_no),
tenant_no number(5) not null references tenant(tenant_no),
date_view date,
comments varchar2(50),
primary key(property_no,tenant_no))
/
create table inspection
(property_no number(5) not null references prop_for_rent(property_no),
staff_no number(5) not null references staff(staff_no),
inspect_date date,
comments varchar2(50),
primary key(property_no,staff_no,inspect_date))
/
insert into branch
values (101,'24 Deer Street','South Hylton','Sunderland','SR5 6PF', '0191 4517892')
/
insert into branch
values (102,'15 Amberley Street',NULL,'Newcastle','SR2 0EZ', '0191 5153127')
/
insert into branch
values (103,'38 Front Street',NULL,'Whitburn','SR2 3ZY', '0191 5483527')
/
insert into branch
values (104,'15 Silver Street',NULL,'Durham','DH4 5TH', '0191 5372522')
/


insert into staff
values(201,101, 'Stewart', 'John', 'Elm Bank Road', 'Pennywell', 'Sunderland', 'SR7 6FE', '0191 7689567', 'M',12350)
/
insert into staff
values(202,101, 'Jones', 'Janice', '63 Wells Street', 'Grindon', 'Sunderland', 'SR4 7RT', '0191 7659447', 'F', 25000)
/
insert into staff
values(203,102, 'Murphy', 'Tina', '12 Fergie Crescent', null, 'Sunderland', 'SR2 3BY', '0191 7554777', 'F', 18000)
/
insert into staff
values(204,102, 'Farrell', 'George', '3 Park Place', 'Pennywell', 'Sunderland', 'SR1 5BC', '0191 6454678', 'M', 14500)
/
insert into staff
values(205,103, 'Kilburn', 'Michael', '2 Ryhope Road', 'Sulgrave', 'Sunderland', 'SR8 2ED', '0191 5675858', 'M', 35000)
/
insert into staff
values(206,104, 'Shaw', 'Sally', '8 Dale Road', 'Benton', 'Sunderland', 'SR2 5AC', '0191 1254698', 'F', 22450)
/
insert into staff
values(207,104, 'Sheldon', 'Stephanie', '125 Le Road', 'Coxhoe', 'Durham', 'DH5 5BA', '0191 2356697', 'F', 12300)
/
insert into owner
values (1331,'Robinson','Simon', '17 Railway Road', null,'Sunderland','SR1 7JL', 500.00)
/
insert into owner
values (1332,'Johnson','Matthew', '8 Rowan Drive', 'Grangetown','Sunderland','SR5 3JT',300.00)
/
insert into owner
values (1333,'Thompson','Maggie', '87 Rowan Drive', 'Grangetown','Sunderland','SR5 3GT',250.00)
/
insert into owner 
values (1334,'Royce','Keith', '21 Queens Road', 'Benton','Newcastle','SR2 6HE',300.00)
/
insert into owner
values (1335,'Morgan','James', '15 Shakespeare Street',NULL,'Sunderland','SR1 2ST',300.00)
/
insert into owner 
values (1336,'Maxwell','Jane', '23 Regent Terrace','Grindon','Sunderland','SR3 7GR',200.00)
/
insert into owner  
values (1337,'Cliff','John', '12 Norman Road','Sulgrave','Sunderland','SR7 6FD', 750.00)
/
insert into owner 
values (1338,'Ashwell','John', 'Elm Bank Road','Pennywell','Sunderland','SR7 6FE',525.00)
/
insert into owner
values (1339,'Platts','Ian','16 Holyhead Road',null,'Sunderland','SR3 5HN',245.00)
/
insert into owner 
values (1340, 'Calvert','Robert', '22 Sherwood Avenue',null, 'Newcastle', 'NE23 6HT',450.00)
/
insert into owner
values (1341,'Best','Marilyn','35 Jerome Street','null', 'Sunderland', 'SR4 6GH',300.00)
/
insert into owner
values (1342,'Green','Harold','8 London Road','Ryhope', 'Sunderland', 'SR3HY',434.00)
/
insert into prop_for_rent
values(1001,'The Cedars','East Mickley','Newcastle','NE76 7YU', 'F',5,650,250.25,1342,
201,101, 'Y', 'Ground Floor Flat with shared main entrance.  Newly decorate. Fitted kitchen.')
/
insert into prop_for_rent
values(1002, 'Belmont Road','Gosforth','Newcastle','NE12 7BY', 'B',4,550,350.70,1333,
201,101, 'N','Deceptively spacious bungalow set in 3rd acre with extensive country views')
/
insert into prop_for_rent
values(1003, 'Bromsmere Court', 'Grangetown','Sunderland','SR2 5BK', 'M',3,450,300,1331,
203,103, 'Y','1950s mid terrace. 25 ft lounge. Fully modernised.')
/
insert into prop_for_rent
values(1004, 'Lassiter Drive',null,'Sunderland','SR6 12K', 'F',2,450,200.50,1332,
204,102, 'Y', 'Centrally situated.  Shared Entrance')
/
insert into prop_for_rent
values(1005, 'Stretton Avenue', 'Gosforth','Newcastle','NE8 3LK', 'S',3,450,200,1334,
204,102, 'Y', 'Modern semi with well equipped kitchen. Garage and Garden')
/

insert into prop_for_rent
values(1006, 'Sharp Rise', null,'Durham','DH5 9LT', 'D',4,550.00,325.67,1335,
206,104, 'N', 'Large family house with double glazing and gas fired central heating')
/
insert into prop_for_rent
values(1007, 'The Oaks' , 'Gosforth','Tyne and Wear','NE8 3HS', 'F',1,300,175,1335,
205,103, 'Y','One bedroom flat.  Suit single person')
/
insert into prop_for_rent
values(1008, 'Chatham Road' , null,'Durham','DH6 3HT', 'D',4,600,480,1336,
206,104, 'Y', 'Well maintained family house in popular area.  Mature gardens and double garage')
/
insert into prop_for_rent
values(1009, 'Prudhoe Road' , 'Sulgrove','Sunderland','SR5 4TB', 'E',3,400,246,1337,
206,101, 'Y', 'Large post-war terrace. Well equipped kitchen')
/
insert into prop_for_rent
values(1010, 'Charles Drive' ,null,'Houghton-Le-Spring','DH7 6LB', 'S',4,650,367,1338,
204,104, 'Y', 'Fully equipped property.  Close to schools and local shops')
/
insert into prop_for_rent
values(1011, 'Chatham Road' , null,'Durham','DH6 3HV', 'B',2,600,380,1336,
206,101, 'Y','Small family bungalow in popular area')
/
insert into prop_for_rent
values(1012, 'Stretton Avenue', 'Gosforth','Newcastle','NE8 3LB', 'S',3,450,285,1334,
204,102, 'Y', 'Modern semi with Garage and Garden')
/
insert into prop_type
values('B','Bungalow')
/
insert into prop_type
values('C','Cottage')
/
insert into prop_type
values('D','Detatched')
/
insert into prop_type
values('E','End-Terrace')
/
insert into prop_type
values('F','Flat')
/
insert into prop_type
values('M','Mid-Terrace')
/
insert into prop_type
values('S','Semi-Detatched')
/
insert into tenant
values(3001, 'Riddell','James', ' 95 Torver Street',null,'Sunderland','SR6 8UP', null, 'H',500)
/
insert into tenant
values(3002, 'Matthews','Peter', '67 Stretton Avenue', 'Gosforth', 'Newcastle','NE6 7RT', '0191 8674252', 'H',650)
/
insert into tenant
values(3003, 'Jackson','James', '6 Strackon Road', null,'Durham', 'DH6 6ET', '0191 6876752', 'F',400)
/
insert into tenant
values(3004, 'Stones','Jasmine', '61 Jackson Drive', 'Ryhope','Sunderland', 'SR6 7TP', '0191 4876952', 'H',500)
/
insert into tenant
values(3005, 'Karping','Annabel', '1 Quay Park', null,'Newcastle', 'NE6 8OP', '0191 4974932', 'F',450)
/
insert into tenant
values(3006, 'Stones','Julie', '8 Bristol Road', null,'Hartlepool', 'HL6 2LM', '0145 7776757', 'H',500)
/
insert into tenant
values(3007, 'Barrymore','Hugh', '25 Arlington Crescent', 'Ryhope','Sunderland', 'SR3 7TY', '0191 3886352', 'H',700)
/
insert into tenant
values(3008, 'Carling','Barry', '16 Rugby Drive', null,'Middlesborough', 'MB6 2PL', '0189 8886552', 'H',550)
/
insert into lease
values(6001,1001,3003,600, 'C',100, 'Y', '12-JUN-1995','05-JUN-1997')
/
insert into lease
values(6002,1002,3002,600, 'X',100, 'Y', '12-JUN-2000', '11-JUN-2001')
/
insert into lease
values(6003,1002,3003,600, 'C',200, 'Y', '12-JUN-1996', '11-JUN-1997')
/
insert into lease
values(6004,1003,3004,500, 'S',50, 'Y', '12-MAR-1994', '13-MAR-1996')
/
insert into lease
values(6005,1004,3005,450,'S',200,'Y','21-MAY-2001', '30-MAY-2001')
/
insert into lease
values(6006,1005,3006,500,'C',100,'Y','30-JUL-1993', '31-JUL-1996')
/
insert into lease
values(6007,1006,3007,450,'S',100,'N','01-MAY-1997', '11-JUN-1998')
/
insert into lease
values(6008,1005,3008,500,'S',100,'Y','21-APR-1995', '11-JUN-1997')
/
insert into lease
values(6009,1008,3003,600,'C',100,'Y','15-MAR-1996', '16-MAR-1997')
/
insert into lease
values(6010,1010,3003,600,'C',100,'Y','12-JUN-1995', null)
/
insert into viewing
values(1001,3001,'10-JUN-1995','Flat is too small')
/
insert into viewing
values(1001,3005,'11-JUN-1995','Too small')
/
insert into viewing
values(1005,3001,'10-JUN-1997','Too far away from local school')
/
insert into viewing
values(1005,3002,'15-JUN-1997','Furniture shabby')
/
insert into viewing
values(1006,3005,'11-JUN-1997','Far too large')
/
insert into inspection
values(1001,201,'12-JUN-1997','No problems')
/
insert into inspection
values(1002,201,'13-JUN-1997','Crockery needs to be replaced')
/
insert into inspection
values(1003,201,'12-JUN-1996','Broken window pane requires urgent repair')
/
insert into inspection
values(1006,203,'21-MAR-1997','No problems')
/
insert into inspection
values(1007,203,'01-DEC-1997','Sofa trim pulled apart by cat. Repair needed')
/
insert into inspection
values(1003,201,'12-JUN-1999','Cracked sink in kitchen requires repair')
/

COMMIT;

