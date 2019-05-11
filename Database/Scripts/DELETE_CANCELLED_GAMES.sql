DO $$ BEGIN
	PERFORM delete_cancelled_games();
END $$;