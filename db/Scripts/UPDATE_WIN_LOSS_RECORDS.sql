DO $$ 
BEGIN
UPDATE team
  SET 
    win_count = subquery.wins,
    loss_count = subquery.losses,
    tie_count = subquery.ties
FROM
  (
    SELECT
      team_id,
	  season_id,
      SUM(win) AS wins,
      SUM(loss) AS losses,
      SUM(tie) AS ties
    FROM
      (
      SELECT 
        t1.team_id AS team_id,
		t1.season_id AS season_id,
        CASE 
          WHEN t1.score > t2.score THEN 1 
          ELSE 0 
        END AS win,
        CASE 
          WHEN t1.score < t2.score THEN 1 
          ELSE 0 
        END AS loss,
        CASE 
          WHEN t1.score = t2.score THEN 1 
          ELSE 0 
        END AS tie
      FROM score t1
      INNER JOIN score t2 
        ON 
          t1.season_id = t2.season_id AND
          t1.game_date = t2.game_date AND
          t1.team_id = t2.opponent_id AND
          t1.opponent_id = t2.team_id AND
          t1.scheduled_ind = 0
      ) win_loss
    GROUP BY team_id, season_id
  ) subquery
WHERE team.id = subquery.team_id and team.season_id = subquery.season_id; 
RAISE INFO 'Updated win-loss records.';
END $$;