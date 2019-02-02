--------------------------------------------------------------------------------
--
-- Sql Command File For Creating And Populating The Property-
-- System Database.-  For use with UNIT 1 - SQL Guide version 1
--
-- Written By: Sue Stirk                                                 -
-- Jan 2002    

---editted by Peter I Mwangi (peter@peter.me.ke)
---JKUAT MSc. IT                                                           -
-------------------------------------------------------------------------------
drop table lease cascade;

drop table viewing cascade;

drop table tenant cascade;

drop table inspection cascade;

drop table prop_for_rent cascade;

drop table prop_type cascade;

drop table owner cascade;

drop table staff cascade;

drop table branc cascade;

create table branch(
	branch_no 		number(3) not null primary key,
	br_street 		varchar2(25) not null,
	br_area 		varchar2(20),
	br_town 		varchar2(20) not null,
	br_pcode 		varchar2(8) not null,
	br_telno 		varchar2(12)
);

create table staff(
	staff_no 		number(5) primary key,
	branch_no 		number(3) references branch(branch_no),
	staff_surname 	varchar2(25) not null,
	staff_forenames varchar2(25) not null,
	staff_street 	varchar2(25) not null,
	staff_area 		varchar2(20),
	staff_town 		varchar2(20) not null,
	staff_pcode 	varchar2(8) not null,
	staff_telno 	varchar2(12),
	staff_gender 	varchar2(1),
	staff_salary 	number (8,2)
);


create table owner(
	owner_no 		number(5) not null primary key,
	ow_surname 		varchar2(25) not null,
	ow_forenames 	varchar2(25) not null,
	ow_street 		varchar2(25) not null,
	ow_area 		varchar2(20),
	ow_town 		varchar2(20) not null,
	ow_pcode 		varchar2(8) not null,
	ow_fee 			number(6,2)
);	

create table prop_for_rent(
	property_no 	number(5) not null primary key,
	prop_street 	varchar2(25) not null,
	prop_area 		varchar2(20),
	prop_town 		varchar2(20) not null,
	prop_pcode 		varchar2(8) not null,
	prop_type 		varchar2(1) not null,
	prop_rooms 		number(2) not null,
	prop_rent_pm 	number(7,2) not null,
	prop_poll_tax 	number(6,2),
	owner_no 		number(5) not null references owner(owner_no),
	staff_no 		number(5) references staff(staff_no), 
	branch_no 		number(3) not null references branch(branch_no),
	available 		varchar2(1),
	comments 		varchar2(150)
);

create table prop_type(
	prop_type 		varchar2(1) not null,
	type_desc 		varchar2(15) not null
);

create table tenant(
	tenant_no 		number(5) not null primary key,
	t_surname 		varchar2(25) not null,
	t_forenames 	varchar2(25) not null,
	t_street 		varchar2(25) not null,
	t_area 			varchar2(20),
	t_town 			varchar2(20) not null,
	t_postcode 		varchar2(8) not null,
	t_telno 		varchar2(12),
	t_pref_type 	varchar2(1),
	t_max_rent 		number(6,2)
);

create table lease(
	lease_no 		number(5) not null primary key,
	property_no 	number(5) not null references prop_for_rent(property_no),
	tenant_no 		number(5) not null references tenant(tenant_no),
	rent_pm 		number(6,2),
	payment_method 	varchar2(1) not null,
	deposit_amount	number(6,2),
	deposit_paid 	varchar2(1),
	stdate 			date not null,
	enddate 		date
);

create table viewing(
	property_no 	number(5) not null references prop_for_rent(property_no),
	tenant_no 		number(5) not null references tenant(tenant_no),
	date_view 		date,
	comments 		varchar2(50),
	primary key(property_no,tenant_no)
);

create table inspection(
	property_no 		number(5) not null references prop_for_rent(property_no),
	staff_no 			number(5) not null references staff(staff_no),
	inspect_date 		date,
	comments 			varchar2(50),
	primary key(property_no,staff_no,inspect_date)
);

insert into branch(branch_no, br_street, br_area, br_town, br_pcode, br_telno) values 
	(101,'24 Deer Street','South Hylton','Sunderland','SR5 6PF', '0191 4517892'),
	(102,'15 Amberley Street',NULL,'Newcastle','SR2 0EZ', '0191 5153127'),
	(103,'38 Front Street',NULL,'Whitburn','SR2 3ZY', '0191 5483527'),
	(104,'15 Silver Street',NULL,'Durham','DH4 5TH', '0191 5372522');



insert into staff(staff_no, branch_no, staff_surname, staff_forenames, staff_street, staff_area, staff_town, staff_pcode, staff_telno, staff_gender, staff_salary) values
	(201,101, 'Stewart', 'John', 'Elm Bank Road', 'Pennywell', 'Sunderland', 'SR7 6FE', '0191 7689567', 'M',12350),
	(202,101, 'Jones', 'Janice', '63 Wells Street', 'Grindon', 'Sunderland', 'SR4 7RT', '0191 7659447', 'F', 25000),
	(203,102, 'Murphy', 'Tina', '12 Fergie Crescent', null, 'Sunderland', 'SR2 3BY', '0191 7554777', 'F', 18000),
	(204,102, 'Farrell', 'George', '3 Park Place', 'Pennywell', 'Sunderland', 'SR1 5BC', '0191 6454678', 'M', 14500),
	(205,103, 'Kilburn', 'Michael', '2 Ryhope Road', 'Sulgrave', 'Sunderland', 'SR8 2ED', '0191 5675858', 'M', 35000),
	(206,104, 'Shaw', 'Sally', '8 Dale Road', 'Benton', 'Sunderland', 'SR2 5AC', '0191 1254698', 'F', 22450),
	(207,104, 'Sheldon', 'Stephanie', '125 Le Road', 'Coxhoe', 'Durham', 'DH5 5BA', '0191 2356697', 'F', 12300);


insert into owner(owner_no, ow_surname, ow_forenames, ow_street, ow_area, ow_town, ow_pcode, ow_fee) values 
	(1331,'Robinson','Simon', '17 Railway Road', null,'Sunderland','SR1 7JL', 500.00),
	(1332,'Johnson','Matthew', '8 Rowan Drive', 'Grangetown','Sunderland','SR5 3JT',300.00),
	(1333,'Thompson','Maggie', '87 Rowan Drive', 'Grangetown','Sunderland','SR5 3GT',250.00), 
	(1334,'Royce','Keith', '21 Queens Road', 'Benton','Newcastle','SR2 6HE',300.00),
	(1335,'Morgan','James', '15 Shakespeare Street',NULL,'Sunderland','SR1 2ST',300.00), 
	(1336,'Maxwell','Jane', '23 Regent Terrace','Grindon','Sunderland','SR3 7GR',200.00),  
	(1337,'Cliff','John', '12 Norman Road','Sulgrave','Sunderland','SR7 6FD', 750.00),
	(1338,'Ashwell','John', 'Elm Bank Road','Pennywell','Sunderland','SR7 6FE',525.00),
	(1339,'Platts','Ian','16 Holyhead Road',null,'Sunderland','SR3 5HN',245.00), 
	(1340, 'Calvert','Robert', '22 Sherwood Avenue',null, 'Newcastle', 'NE23 6HT',450.00),
	(1341,'Best','Marilyn','35 Jerome Street','null', 'Sunderland', 'SR4 6GH',300.00),
	(1342,'Green','Harold','8 London Road','Ryhope', 'Sunderland', 'SR3HY',434.00);


insert into prop_for_rent (property_no, prop_street, prop_area, prop_town, prop_pcode, prop_type, prop_rooms, prop_rent_pm, prop_poll_tax, owner_no, staff_no, branch_no, available, comments) values
	(1001,'The Cedars','East Mickley','Newcastle','NE76 7YU', 'F',5,650,250.25,1342,201,101, 'Y', 'Ground Floor Flat with shared main entrance.  Newly decorate. Fitted kitchen.'),
	(1002, 'Belmont Road','Gosforth','Newcastle','NE12 7BY', 'B',4,550,350.70,1333,201,101, 'N','Deceptively spacious bungalow set in 3rd acre with extensive country views'),
	(1003, 'Bromsmere Court', 'Grangetown','Sunderland','SR2 5BK', 'M',3,450,300,1331,203,103, 'Y','1950s mid terrace. 25 ft lounge. Fully modernised.'),
	(1004, 'Lassiter Drive',null,'Sunderland','SR6 12K', 'F',2,450,200.50,1332,204,102, 'Y', 'Centrally situated.  Shared Entrance'),
	(1005, 'Stretton Avenue', 'Gosforth','Newcastle','NE8 3LK', 'S',3,450,200,1334,204,102, 'Y', 'Modern semi with well equipped kitchen. Garage and Garden'),
	(1006, 'Sharp Rise', null,'Durham','DH5 9LT', 'D',4,550.00,325.67,1335,206,104, 'N', 'Large family house with double glazing and gas fired central heating'),
	(1007, 'The Oaks' , 'Gosforth','Tyne and Wear','NE8 3HS', 'F',1,300,175,1335,205,103, 'Y','One bedroom flat.  Suit single person'),
	(1008, 'Chatham Road' , null,'Durham','DH6 3HT', 'D',4,600,480,1336,206,104, 'Y', 'Well maintained family house in popular area.  Mature gardens and double garage'),
	(1009, 'Prudhoe Road' , 'Sulgrove','Sunderland','SR5 4TB', 'E',3,400,246,1337,206,101, 'Y', 'Large post-war terrace. Well equipped kitchen'),
	(1010, 'Charles Drive' ,null,'Houghton-Le-Spring','DH7 6LB', 'S',4,650,367,1338,204,104, 'Y', 'Fully equipped property.  Close to schools and local shops'),
	(1011, 'Chatham Road' , null,'Durham','DH6 3HV', 'B',2,600,380,1336,206,101, 'Y','Small family bungalow in popular area'),
	(1012, 'Stretton Avenue', 'Gosforth','Newcastle','NE8 3LB', 'S',3,450,285,1334,204,102, 'Y', 'Modern semi with Garage and Garden');


insert into prop_type (prop_type, type_desc) values
	('B','Bungalow'),
	('C','Cottage'),
	('D','Detatched'),
	('E','End-Terrace'),
	('F','Flat'),
	('M','Mid-Terrace'),
	('S','Semi-Detatched');


insert into tenant (tenant_no, t_surname, t_forenames, t_street, t_area, t_town, t_postcode, t_telno, t_pref_type, t_max_rent) values
	(3001, 'Riddell','James', ' 95 Torver Street',null,'Sunderland','SR6 8UP', null, 'H',500),
	(3002, 'Matthews','Peter', '67 Stretton Avenue', 'Gosforth', 'Newcastle','NE6 7RT', '0191 8674252', 'H',650),
	(3003, 'Jackson','James', '6 Strackon Road', null,'Durham', 'DH6 6ET', '0191 6876752', 'F',400),
	(3004, 'Stones','Jasmine', '61 Jackson Drive', 'Ryhope','Sunderland', 'SR6 7TP', '0191 4876952', 'H',500),
	(3005, 'Karping','Annabel', '1 Quay Park', null,'Newcastle', 'NE6 8OP', '0191 4974932', 'F',450),
	(3006, 'Stones','Julie', '8 Bristol Road', null,'Hartlepool', 'HL6 2LM', '0145 7776757', 'H',500),
	(3007, 'Barrymore','Hugh', '25 Arlington Crescent', 'Ryhope','Sunderland', 'SR3 7TY', '0191 3886352', 'H',700),
	(3008, 'Carling','Barry', '16 Rugby Drive', null,'Middlesborough', 'MB6 2PL', '0189 8886552', 'H',550);

-----------failed to run dates order mmddyyyy
insert into lease (lease_no, property_no, tenant_no, rent_pm, payment_method, deposit_amount, deposit_paid, stdate, enddate) values
	(6001,1001,3003,600, 'C',100, 'Y', '6-12-1995','6-05-1997'),
	(6002,1002,3002,600, 'X',100, 'Y', '6-12-2000', '6-11-2001'),
	(6003,1002,3003,600, 'C',200, 'Y', '6-12-1996', '6-11-1997'),
	(6004,1003,3004,500, 'S',50, 'Y', '3-12-1994', '3-13-1996'),
	(6005,1004,3005,450,'S',200,'Y','5-21-2001', '5-30-2001'),
	(6006,1005,3006,500,'C',100,'Y','7-30-1993', '7-31-1996'),
	(6007,1006,3007,450,'S',100,'N','5-01-1997', '11-6-1998'),
	(6008,1005,3008,500,'S',100,'Y','4-21-1995', '11-6-1997'),
	(6009,1008,3003,600,'C',100,'Y','3-15-1996', '3-16-1997'),
	(6010,1010,3003,600,'C',100,'Y','6-12-1995', null);

---bad insert
insert into viewing (property_no, tenant_no, date_view, comments) values
	(1001,3001,'6-10-1995','Flat is too small'),
	(1001,3005,'6-11-1995','Too small'),
	(1005,3001,'6-10-1997','Too far away from local school'),
	(1005,3002,'6-15-1997','Furniture shabby'),
	(1006,3005,'6-11-1997','Far too large');


insert into inspection (property_no, staff_no, inspect_date, comments) values
	(1001,201,'6-12-1997','No problems'),
	(1002,201,'6-13-1997','Crockery needs to be replaced'),
	(1003,201,'6-12-1996','Broken window pane requires urgent repair'),
	(1006,203,'3-21-1997','No problems'),
	(1007,203,'12-01-1997','Sofa trim pulled apart by cat. Repair needed'),
	(1003,201,'6-12-1999','Cracked sink in kitchen requires repair');


COMMIT;

