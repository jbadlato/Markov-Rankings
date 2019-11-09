DO $$
DECLARE
	cnt INTEGER;
BEGIN
	-- Add display_name column to league table:
	BEGIN
		ALTER TABLE league ADD COLUMN display_name VARCHAR(255);
	EXCEPTION
		WHEN duplicate_column THEN RAISE NOTICE 'column display_name already exists in table league.';
	END;
	
	-- Update the display names for the leagues:
	UPDATE league SET display_name = 'NCAA Division I Men''s Basketball' WHERE name = 'CBB';
	UPDATE league SET display_name = 'NCAA Division I FBS Football' WHERE name = 'CFB';
	UPDATE league SET display_name = 'NFL Football' WHERE name = 'NFL';
	UPDATE league SET display_name = 'NHL Hockey' WHERE name = 'NHL';
	UPDATE league SET display_name = 'NCAA Division I Women''s Basketball' WHERE name = 'WCBB';
	UPDATE league SET display_name = 'NBA Basketball' WHERE name = 'NBA';
	UPDATE league SET display_name = 'NCAA Division I Men''s Lacrosse' WHERE name = 'MLAX';
	UPDATE league SET display_name = 'NCAA Division I Women''s Lacrosse' WHERE name = 'WLAX';
	--===================================================
	-- UPDATE VERSION
	--===================================================
	INSERT INTO db_version (version, date_applied, notes)
		VALUES ('1.5',NOW(),'Adding verbose league names');
END $$;