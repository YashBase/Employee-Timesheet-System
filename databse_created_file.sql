create database if not exists netproject;
use netproject;

/*total tables*/
/* 1. role 2.user 3. project 4.timesheet 5.timesheetentry  6.auditlog*/





/*role table*/
create table if not exists role(role_id int auto_increment primary key, role_name enum('Employee','Manager','Admin') not null);

/* user table */
create table if not exists user(
	user_id int auto_increment primary key,
    full_name varchar(255) not null,
    email varchar(100) not null,
    password_hash varchar(255) not null,
    role_id int not null,
    is_active boolean default true,
    created_at timestamp default current_timestamp,
    foreign key (role_id) references role(role_id)
	);
    
/* project table */
create table if not exists project(
	project_id int auto_increment primary key,
    project_name varchar(100) not null unique,
    description text,
    start_date Date,
    end_date Date
	);    


/* timesheet table */
create table if not exists timesheet(
	timesheet_id int auto_increment primary key,
    user_id int not null,
    week_start_date Date not null,
    status Enum('Pending','Submitted','Approved','Rejected') default 'Pending',
    submitted_at datetime default null,
    approved_by int default null,
    comments text,
    created_at timestamp default current_timestamp,
    foreign key (user_id) references user(user_id),
    foreign key (approved_by) references user(user_id),
    unique(user_id,week_start_date)
	);
    
    /* timesheetentry */
    create table if not exists timesheetentry(
		entry_id int auto_increment primary key,
        timesheet_id int not null,
        project_id int not null,
        work_date Date not null,
        hours_worked decimal(4,2) check(hours_worked between 0 and 24),
        task_description varchar(255),
        foreign key(timesheet_id ) references timesheet(timesheet_id),
        foreign key(project_id) references project(project_id),
        unique(timesheet_id,project_id,work_date)
		);
        
        
/*auditlogs table*/
create table if not exists auditlogs(
	log_id int auto_increment primary key,
    table_name varchar(50),
    action_type enum('insert','update','delete'),
    record_id int,
    log_time timestamp default current_timestamp,
    old_data text,
    new_data text
	);        
