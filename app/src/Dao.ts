export interface Dao<T> {
	public get(id: number): T | null;
	
	public create(t: T): void;
	
	public delete(t: T): void;
}