
/* update trigger  timesheet*/

delimiter $$
create trigger log_timesheet_update
after update on timesheet
for each row
begin 
	insert into auditlogs(table_name, action_type, record_id,old_data,new_data)
	values(
		'timesheet',
        'update',
        NEW.timesheet_id,
        concat('status:',OLD.status,', approved by:', OLD.approved_by),
        concat('status:', NEW.status,', approved by:', NEW.status)
		);
end$$

delimiter ;
