create database RK2;
create schema rk2;
drop table  rk2.animals CASCADE;
drop table  rk2.owners CASCADE;
drop table  rk2.diseases CASCADE;
drop table  rk2.AO CASCADE;
drop table  rk2.AD CASCADE;

create table rk2.regions
(
	regionid serial primary key,
	regionname varchar,
	regiondescription varchar
);

create table rk2.sanatorium
(
	sanatoriumid serial primary key,
	sanatoriumname varchar,
	sanatoriumyear int,
	sanatoriumdescription varchar,
	regionid INT,
	FOREIGN KEY (regionid) REFERENCES rk2.regions(regionid)
);

create table rk2.vacationers
(
	vacationerid serial primary key,
	vacationerfio varchar,
	vacationeryear int,
	vacationeraddress varchar,
	vacationeremail varchar
);

create table rk2.SV
(
	SVID serial primary key,
	vacationerid integer references rk2.vacationers (vacationerid),
	sanatoriumid integer references rk2.sanatorium (sanatoriumid)
);

insert into rk2.regions (regionname, regiondescription) values ('Brown brocket', 'Mazama gouazoubira');
insert into rk2.regions (regionname, regiondescription) values ('Red-cheeked cordon bleu', 'Uraeginthus bengalus');
insert into rk2.regions (regionname, regiondescription) values ('American racer', 'Coluber constrictor');
insert into rk2.regions (regionname, regiondescription) values ('Land iguana', 'Conolophus subcristatus');
insert into rk2.regions (regionname, regiondescription) values ('Shelduck, common', 'Tadorna tadorna');
insert into rk2.regions (regionname, regiondescription) values ('Sandpiper, spotted wood', 'Tringa glareola');
insert into rk2.regions (regionname, regiondescription) values ('Great white pelican', 'Pelecans onocratalus');
insert into rk2.regions (regionname, regiondescription) values ('Wallaroo, common', 'Macropus robustus');
insert into rk2.regions (regionname, regiondescription) values ('Spider, wolf', 'Lycosa godeffroyi');
insert into rk2.regions (regionname, regiondescription) values ('Hanuman langur', 'Semnopithecus entellus');
insert into rk2.regions (regionname, regiondescription) values ('Dik, kirk''s dik', 'Madoqua kirkii');

insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Selby Ornils', 1934, '20th Floor', 'sornils0@army.mil');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Giffard Nickerson', 1982, 'Suite 59', 'gnickerson1@tripod.com');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Arlyn Chaise', 1983, '1st Floor', 'achaise2@live.com');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Ermentrude Imloch', 1971, 'Suite 21', 'eimloch3@youtu.be');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Alberta Houndsom', 1943, 'PO Box 41992', 'ahoundsom4@opera.com');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Neely Ciccottini', 1949, 'Apt 1669', 'nciccottini5@un.org');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Bastian McIsaac', 1941, 'Suite 53', 'bmcisaac6@parallels.com');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Kris Records', 1978, 'PO Box 632', 'krecords7@omniture.com');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Joletta Haversum', 1986, 'Apt 920', 'jhaversum8@com.com');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Hamlin Lafflin', 1983, 'Apt 1233', 'hlafflin9@dailymotion.com');
insert into rk2.vacationers (vacationerfio, vacationeryear, vacationeraddress, vacationeremail) values ('Brander Kinane', 1932, 'Apt 946', 'bkinanea@imageshack.us');


insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Wikivu', 2001, 'Retinopathy of prematurity, stage 3', 2);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Feedbug', 1988, 'Wedge comprsn fx unsp thor vert, subs for fx w routn heal', 1);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Jabberstorm', 1989, 'Displ avuls fx tuberosity of unsp calcaneus, 7thG', 3);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Realmix', 1992, 'Corrosion of unsp deg mult sites of right ank/ft, sequela', 3);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Rhybox', 2005, 'Burn of unspecified degree of left palm, subs encntr', 11);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Divavu', 2008, 'Monocular exotropia, left eye', 5);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Gigabox', 2009, 'Unspecified fracture of fifth metacarpal bone, left hand', 10);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Edgeblab', 1985, 'Underdosing of benzodiazepines, subsequent encounter', 5);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Edgeify', 2006, 'Injury of acoustic nerve, right side, initial encounter', 7);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Edgeify', 2002, 'Contusion of unspecified eyelid and periocular area, sequela', 1);
insert into rk2.sanatorium (sanatoriumname, sanatoriumyear, sanatoriumdescription, regionid) values ('Yambee', 1997, 'Disp fx of body of unsp talus, init for clos fx', 5);

insert into rk2.sv (vacationerid, sanatoriumid) values (4, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (2, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (3, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (8, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (10, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (6, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (4, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (10, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (5, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (4, 11);
insert into rk2.sv (vacationerid, sanatoriumid) values (7, 11);

