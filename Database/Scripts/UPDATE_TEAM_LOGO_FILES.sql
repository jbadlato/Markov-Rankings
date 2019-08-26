DO $$
BEGIN
	PERFORM update_team_logos();
	RAISE INFO 'Updated team logos.';
END $$;