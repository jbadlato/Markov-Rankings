-- Testing continuous deployment patch

--===================================================
-- UPDATE VERSION
--===================================================
INSERT INTO db_version (version, date_applied, notes)
	VALUES ('1.1',NOW(),'Testing CD automatic patching');