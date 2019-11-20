DO $$
BEGIN
	UPDATE score 
		SET scheduled_ind = 
		CASE 
			WHEN game_date <= DATE(CURRENT_DATE AT TIME ZONE 'US/Pacific') THEN 0 
			ELSE 1 
		END;
	RAISE INFO 'Updated scheduled indicators.';
END $$;