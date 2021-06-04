create table locations(
	location_id int primary key generated always as identity,
	address varchar(250),
	city varchar(100),
	state varchar(50),
	zipcode varchar(10)
);

create table specialty(
	specialty_id int primary key generated always as identity,
	specialty varchar(250)
);

create table organization(
	org_id int primary key generated always as identity,
	org_name varchar(100),
	headquarters int,
	constraint fk_org_hq foreign key (headquarters) references locations(location_id)
);

create table certification(
	cert_id int primary key generated always as identity,
	certification varchar(100),
	description varchar(250)
);

create table org_team(
	team_id int primary key generated always as identity,
	organization int,
	constraint fk_team_org foreign key (organization) references organization(org_id)
);

CREATE TABLE org_member(
	member_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	first_name varchar(50),
	last_name varchar(50),
	job_title varchar(100),
	specialty int,
	certification int,
	team int,
	constraint fk_member_cert foreign key (certification) references certification(cert_id),
	constraint fk_member_specialty foreign key (specialty) references specialty(specialty_id),
	constraint fk_member_team foreign key (team) references org_team(team_id)
);


CREATE TABLE patient(
	patient_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	first_name varchar(50),
	last_name varchar(50),
	age int,
	height int,
	weight int,
	injury varchar(250),
	location_id int,
	physician_id int,
	therapist_id int,
	CONSTRAINT fk_patient_therapist FOREIGN KEY (therapist_id) REFERENCES org_member(member_id),
	CONSTRAINT fk_patient_physician FOREIGN KEY (physician_id) REFERENCES org_member(member_id),
	CONSTRAINT fk_patient_location FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE protocol(
	protocol_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	patient_id int,
	description varchar(200),
	CONSTRAINT fk_protocol_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);

CREATE TABLE activity(
	activity_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	name varchar(200),
	description varchar(200)
);

CREATE TABLE exercise(
	exercise_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	set_count int,
	rep_count int,
	intensity int,
	activity_id int,
	CONSTRAINT fk_exercise_activity FOREIGN KEY (activity_id) REFERENCES activity(activity_id)
);


CREATE TABLE workout(
	workout_id int PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	day_number int,
	exercise_id int,
	protocol_id int,
	CONSTRAINT fk_ep_protocol FOREIGN KEY (protocol_id) REFERENCES protocol(protocol_id),
	CONSTRAINT fk_ep_exercise FOREIGN KEY (exercise_id) REFERENCES exercise(exercise_id)
);


drop table org_team;
drop table org_member;
drop table workout;
drop table protocol;
drop table exercise;
drop table activity;
drop table patient;

drop table locations;
drop table organization;
drop table specialty;
drop table therapist;



