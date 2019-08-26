DO $$ 
BEGIN
	PERFORM delete_cancelled_games();
	RAISE INFO 'Deleted cancelled games.';
END $$;