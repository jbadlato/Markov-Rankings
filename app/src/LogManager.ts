import { configure, getLogger, Logger } from 'log4js';

export class LogManager {
	private const logger: Logger;
	
	public constructor() {
		// TODO: config could be moved to JSON file
		// TODO: add a file output option as well
		configure({
			appenders: { 'out': { type: 'stdout' } },
			categories: { default: { appenders: ['out'], level: 'info' } }
		});
		this.logger = getLogger();
		this.logger.level = process.env.LOG_LEVEL;
	}
	
	public getLogger() {
		return this.logger;
	}
}