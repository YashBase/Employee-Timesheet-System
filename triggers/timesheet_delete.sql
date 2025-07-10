
/* trigger delete time sheet entry */

delimiter $$

create trigger log_entry_delete
after delete on timesheetentry
for each row
begin
	insert into auditlogs(table_name,action_type,record_id,old_data)
    values(
		'timesheetentry',
        'delete',
        OLD.entry_id,
        concat('workdate:', OLD.work_date,', hours:', OLD.hours_worked)
		);
end$$

delimiter ;