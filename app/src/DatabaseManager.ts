const { Client } = require('pg');

export class DatabaseManager {
	private const client: Client;
	
	public constructor(connectionString: string) {
		this.client = new Client({
			connectionString: connectionString
		});
	}
	
	public connect(): Promise {
		return new Promise((resolve, reject) => {
			this.client.connect((err) => {
				if (err) {
					console.log('Error connecting to database.');
					reject(err);
				} else {
					console.log('Connected to database successfully.');
					resolve();
				}
			});
		});
	}
	
	public disconnect(): Promise {
		return new Promise((resolve, reject) => {
			this.client.end((err) => {
				if (err) {
					console.log('Error disconnecting from database.');
					reject(err);
				} else {
					console.log('Disconnected from database successfully.');
					resolve();
				}
			});
		});
	}
	
	public query(queryString: string, params?: Array<any>): Promise {
		return new Promise((resolve, reject) => {
			this.client.query(queryString, params, (err, res) => {
				if (err) {
					console.log('Error running query.');
					reject(err);
				} else {
					console.log('Query successful: ' + queryString + params);
					resolve(res);
				}
			});
		});
	}
}