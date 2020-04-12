//MARK: - Subscripts
//Shortcuts for accessing the member elements of a collection, list, or sequence.
//Use subscripts to set and retrieve values by index without needing separate methods(ex. Array[index] and Dictionary[key]

//MARK: - Subscript Syntax
//Write subscript definitions with the "subscript" keyword
//Subscripts can only be read-write or read-only, this is communicated by a getter and setter.
//subscript(index: Int) -> Int {
//    get {
//        //Return the subscript value here.
//    }
//    //newValue is the same as the retrun value of the subscript
//    set(newValue) {
//        //Perform an action here
//    }
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
//Declare the instance and set the multiplier constant
let threeTimesTable = TimesTable(multiplier: 3)
print("Six times three is \(threeTimesTable[6])")

//MARK: - Subscript Usage
//Swift's Dictionary type implements a subscript to set and retrieve the values stored in a Dictionary instance
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2

//MARK: - Subscript Options
//Subscripts can take any number of input parameters, and the parameters can be of any type
//Similar to functions, but subscripts can't use "in-out" parameters

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool  {
        //Check to see greater than 0 and less than max number of rows/columns
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        //Return the value at the row and column
        get {
            //assert statements will force the app to crash if the condition isn't true
            //great for debugging because, Xcode strips them in release builds
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
            
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
            
        }
    }
}

//Create a new Matrix instance
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 1] = 25
matrix.grid

//MARK: - Type Subscripts
//Subscripts can also be called on the type itself = type subscript
//"static" keyword indicates a type subscript

enum Planet: Int {
 case mercury = 1, venus, earth, mars, jupiter, starun, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
//The subscript is called on the Planet type
let mars = Planet[4]
print(mars)

