DO $$
BEGIN
	PERFORM update_team_conferences();
	RAISE INFO 'Updated team conferences.';
END $$;