export class Matrix {
	private matrix: Array<Array<number>>;
	
	public constructor(m: number, n: number, val: number) {
		if (m <= 0 || n <= 0) {
			throw new Error('Matrix dimensions must be greater than zero');
		}
		this.matrix = [];
		for (let i: number = 0; i < m; i++) {
			this.matrix[i] = [];
			for (let j: number = 0; j < n; j++) {
				this.matrix[i][j] = val;
			}
		}
	}
	
	public get(i: number, j: number): number {
		if (i < 0 || j < 0 || i >= this.getHeight() || j >= this.getWidth()) {
			throw new Error("Matrix index out of range");
		}
		return this.matrix[i][j];
	}
	
	public set(i: number, j: number, val: number): void {
		if (i < 0 || j < 0 || i >= this.getHeight() || j >= this.getWidth()) {
			throw new Error("Matrix index out of range");
		}
		this.matrix[i][j] = val;
	}
	
	public getHeight(): number {
		return this.matrix.length;
	}
	
	public getWidth(): number {
		return this.matrix[0].length;
	}
	
	public transpose(): Matrix {
		let result = new Matrix(this.getWidth(), this.getHeight(), 0);
		for (let i: number = 0; i < result.getHeight(); i++) {
			for (let j: number = 0; j < result.getWidth(); j++) {
				result.set(i,j,this.get(j,i));
			}
		}
		return result;
	}
	
	public multiply(b: Matrix) : Matrix {
		if (this.getWidth() !== b.getHeight()) {
			throw new Error(`Dimensions of matrices are not compatible:\n  ${this.getHeight()}x${this.getWidth()} * ${b.getHeight()}x${b.getWidth()}`);
		}
		let product: Matrix = new Matrix(this.getHeight(), b.getWidth(), 0); 
		for (let i: number = 0; i < product.getHeight(); i++) {
			for (let j: number = 0; j < product.getWidth(); j++) {
				let sum: number = 0;
				for (let k: number = 0; k < this.getWidth(); k++) {
					sum += this.get(i,k) * b.get(k,j);
				}
				product.set(i, j, sum);
			}
		}
		return product;
	}
}