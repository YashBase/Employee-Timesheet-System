
/* timesheet insert */

delimiter $$
create trigger log_timesheet_insert
after insert on timesheet
for each row
begin 
	insert into auditlogs(table_name, action_type,record_id,new_data) values('timesheet','insert',NEW.timesheet_id,concat('user_id:',NEW.user_id,', week:',NEW.week_start_date));
end$$

delimiter ;

show triggers;
    