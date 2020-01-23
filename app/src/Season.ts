export class Season {
	id: number;
	leagueId: number | null;
	season: number | null;
	teamsUrl: string | null;
	scoresUrl: string | null;
	weekStart: number | null;
	seasonStart: Date | null;
	seasonEnd: Date | null;
	
	constructor(id: number, leagueId: number, season: number, teamsUrl: string, scoresUrl: string, weekStart: number, seasonStart: Date, seasonEnd: Date) {
		
	}
}