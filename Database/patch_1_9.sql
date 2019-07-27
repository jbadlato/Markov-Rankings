DO $$
DECLARE
	cnt INTEGER;
BEGIN 
	
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.9',NOW(),'Adding new seasons for 2019');
END $$;