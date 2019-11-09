import { Client } from 'pg';
import { LogManager } from './LogManager';
import { Logger } from 'log4js';

export class DatabaseManager {
	private const client: Client;
	private const logger: Logger;
	
	public constructor(connectionString: string) {
		this.logger = new LogManager().getLogger();
		this.client = new Client({
			connectionString: connectionString
		});
	}
	
	public connect(): Promise {
		return new Promise((resolve, reject) => {
			this.client.connect((err) => {
				if (err) {
					this.logger.error('Error connecting to database.');
					reject(err);
				} else {
					this.logger.debug('Connected to database successfully.');
					resolve();
				}
			});
		});
	}
	
	public disconnect(): Promise {
		return new Promise((resolve, reject) => {
			this.client.end((err) => {
				if (err) {
					this.logger.error('Error disconnecting from database.');
					reject(err);
				} else {
					this.logger.debug('Disconnected from database successfully.');
					resolve();
				}
			});
		});
	}
	
	public query(queryString: string, params?: Array<any>): Promise {
		return new Promise((resolve, reject) => {
			this.client.query(queryString, params, (err, res) => {
				if (err) {
					this.logger.error('Error running query.');
					reject(err);
				} else {
					this.logger.debug('Query successful: ' + queryString + params);
					resolve(res);
				}
			});
		});
	}
}