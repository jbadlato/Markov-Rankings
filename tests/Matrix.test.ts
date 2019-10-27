import { Matrix } from '../src/Matrix';

describe('Construct, Get, Set', () => {
	it('zeros', () => {
		const m: Matrix = new Matrix(4,4,0);
		for (let i: number = 0; i < 4; i++) {
			for (let j: number = 0; j < 4; j++) {
				expect(m.get(i, j)).toBe(0);
			}
		}
	});
	
	it('floats', () => {
		const m: Matrix = new Matrix(2,3,4.55);
		for (let i: number = 0; i < 2; i++) {
			for (let j: number = 0; j < 3; j++) {
				expect(m.get(i, j)).toBe(4.55);
			}
		}
	});
	
	it('invalid dimensions', () => {
		expect(() => new Matrix(0,1,1)).toThrow();
		expect(() => new Matrix(1,0,1)).toThrow();
		expect(() => new Matrix(-2,-2,-2)).toThrow();
	});
	
	it('height & width', () => {
		const m: Matrix = new Matrix(5,6,2);
		expect(m.getHeight()).toEqual(5);
		expect(m.getWidth()).toEqual(6);
	});
	
	it('out of bounds', () => {
		const m: Matrix = new Matrix(3,6,1);
		expect(m.get(0,2)).toEqual(1);
		expect(m.get(2,0)).toEqual(1);
		m.set(0,2,5);
		m.set(2,0,8);
		expect(m.get(0,2)).toEqual(5);
		expect(m.get(2,0)).toEqual(8);
		expect(() => m.get(3,0)).toThrow();
		expect(() => m.get(0,6)).toThrow();
		expect(() => m.set(3,0,10)).toThrow();
		expect(() => m.set(0,6,100)).toThrow();
	});
});

describe('Transpose', () => {
	it('rectangular', () => {
		const m: Matrix = new Matrix(2,5,0);
		let count: number = 0;
		for (let i: number = 0; i < m.getHeight(); i++) {
			for (let j: number = 0; j < m.getWidth(); j++) {
				m.set(i,j,count);
				count++;
			}
		}
		const expected: Matrix = new Matrix(5,2,0);
		count = 0;
		for (let j: number = 0; j < expected.getWidth(); j++) {
			for (let i: number = 0; i < expected.getHeight(); i++) {
				expected.set(i,j,count);
				count++;
			}
		}
		const actual: Matrix = m.transpose();
		expect(actual).toEqual(expected);
	});
	
	it('square', () => {
		const m: Matrix = new Matrix(4,4,0);
		let count: number = 0;
		for (let i: number = 0; i < m.getHeight(); i++) {
			for (let j: number = 0; j < m.getWidth(); j++) {
				m.set(i,j,count);
				count++;
			}
		}
		count = 0;
		const expected: Matrix = new Matrix(4,4,0);
		for (let j: number = 0; j < expected.getWidth(); j++) {
			for (let i: number = 0; i < expected.getHeight(); i++) {
				expected.set(i,j,count);
				count++;
			}
		}
		const actual: Matrix = m.transpose();
		expect(actual).toEqual(expected);
	});
	
	it('one by one', () => {
		const m: Matrix = new Matrix(1,1,7);
		expect(m.transpose()).toEqual(m);
	});
});

describe('Multiply', () => {
	it('rectangular', () => {
		const a: Matrix = new Matrix(2,3,0);
		a.set(0,0,1);
		a.set(0,1,2);
		a.set(0,2,3);
		a.set(1,0,4);
		a.set(1,1,5);
		a.set(1,2,6);
		const b: Matrix = new Matrix(3,1,0);
		b.set(0,0,10);
		b.set(1,0,11);
		b.set(2,0,12);
		const expected: Matrix = new Matrix(2,1,0);
		expected.set(0,0,68);
		expected.set(1,0,167);
		const actual: Matrix = a.multiply(b);
		expect(actual).toEqual(expected);
	});
	
	it('square', () => {
		const a: Matrix = new Matrix(3,3,1);
		const b: Matrix = new Matrix(3,3,5);
		const expected: Matrix = new Matrix(3,3,15);
		const actual: Matrix = a.multiply(b);
		expect(actual).toEqual(expected);
	});
	
	it('incompatible dimensions', () => {
		const a: Matrix = new Matrix(2,3,1);
		const b: Matrix = new Matrix(6,6,1);
		expect(() => a.multiply(b)).toThrow();
	});
});