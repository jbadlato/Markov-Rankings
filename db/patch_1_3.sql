UPDATE league SET logo_file = 'ncaa_lacrosse.png' WHERE id = 7;

--===================================================
-- UPDATE VERSION
--===================================================
INSERT INTO db_version (version, date_applied, notes)
	VALUES ('1.3',NOW(),'Fixing college lacrosse logo');