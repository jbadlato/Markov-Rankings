"use strict";
exports.__esModule = true;
var Matrix = /** @class */ (function () {
    function Matrix(m, n, val) {
        if (m <= 0 || n <= 0) {
            throw new Error('Matrix dimensions must be greater than zero');
        }
        this.matrix = [];
        for (var i = 0; i < m; i++) {
            this.matrix[i] = [];
            for (var j = 0; j < n; j++) {
                this.matrix[i][j] = val;
            }
        }
    }
    Matrix.prototype.get = function (i, j) {
        if (i < 0 || j < 0 || i >= this.getHeight() || j >= this.getWidth()) {
            throw new Error("Matrix index out of range");
        }
        return this.matrix[i][j];
    };
    Matrix.prototype.set = function (i, j, val) {
        if (i < 0 || j < 0 || i >= this.getHeight() || j >= this.getWidth()) {
            throw new Error("Matrix index out of range");
        }
        this.matrix[i][j] = val;
    };
    Matrix.prototype.getHeight = function () {
        return this.matrix.length;
    };
    Matrix.prototype.getWidth = function () {
        return this.matrix[0].length;
    };
    Matrix.prototype.getRow = function (i) {
        if (i < 0 || i >= this.getHeight()) {
            throw new Error('Matrix index out of range');
        }
        return this.matrix[i];
    };
    Matrix.prototype.transpose = function () {
        var result = new Matrix(this.getWidth(), this.getHeight(), 0);
        for (var i = 0; i < result.getHeight(); i++) {
            for (var j = 0; j < result.getWidth(); j++) {
                result.set(i, j, this.get(j, i));
            }
        }
        return result;
    };
    Matrix.prototype.multiply = function (b) {
        if (this.getWidth() !== b.getHeight()) {
            throw new Error("Dimensions of matrices are not compatible:\n  " + this.getHeight() + "x" + this.getWidth() + " * " + b.getHeight() + "x" + b.getWidth());
        }
        var product = new Matrix(this.getHeight(), b.getWidth(), 0);
        for (var i = 0; i < product.getHeight(); i++) {
            for (var j = 0; j < product.getWidth(); j++) {
                var sum = 0;
                for (var k = 0; k < this.getWidth(); k++) {
                    sum += this.get(i, k) * b.get(k, j);
                }
                product.set(i, j, sum);
            }
        }
        return product;
    };
    return Matrix;
}());
exports.Matrix = Matrix;
