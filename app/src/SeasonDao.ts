import { Dao } from './Dao';
import { Season } from './Season';
import { DatabaseManager } from './DatabaseManager';

export class SeasonDao implements Dao<Season> {
	
	static const QUERY_STRING_SAVE: string = "INSERT INTO season (id, league_id, season, teams_url, scores_url, week_start, season_start, season_end) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)";
	static const QUERY_STRING_GET: string = "SELECT id, league_id, season, teams_url, scores_url, week_start, season_start, season_end FROM season WHERE id = $1";
	static const QUERY_STRING_DELETE: string = "DELETE FROM season WHERE id = $1";
	
	const dbManager: DatabaseManager;
	
	public constructor() {
		this.dbManager = new DatabaseManager(process.env.BACKEND_DATABASE_URL);
	}
	
	public async get(id: number): Season | null {
		await dbManager.connect();
		let params: Array<any> = [ id ];
		let result: Season = await dbManager.query(QUERY_STRING_GET, params).then((res) => {
			resolve(new Season(
		});
		await dbManager.disconnect();
	}
	
	public async create(seasonObj: Season) {
		await dbManager.connect();
		let params: Array<any> = [ seasonObj.getId(), seasonObj.getLeagueId(), seasonObj.getSeason(), seasonObj.getTeamsUrl(), seasonObj.getScoresUrl(),
			seasonObj.getWeekStart(), seasonObj.getSeasonStart(), seasonObj.getSeasonEnd() ];
		await dbManager.query(QUERY_STRING_SAVE, params);
		await dbManager.disconnect();
	}
	
	public async delete(seasonObj: Season) {
		await dbManager.connect();
		let params: Array<any> = [ seasonObj.getId() ];
		await dbManager.
		await dbManager.disconnect(q, params);
	}
}