UPDATE score 
	SET scheduled_ind = 
	CASE 
		WHEN game_date < CURRENT_DATE THEN 0 
		ELSE 1 
	END;