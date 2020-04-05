import UIKit

var str = "Hello, playground"
//
//Argument Labels

//Argument name can provide context for the function caller
//_ argument name is used when it will be redundant with parameter name
func sayHello(_ firstParameterName: String, secondParameterName: String) {
    print(firstParameterName + secondParameterName)
}

sayHello("hello", secondParameterName: "you")
//
// Variadic Parameters

//Specify that the paratmer can be passed a varying number of input values

func mean(_ numberList: Double...) -> Double {
    var sum: Double = 0
    for number in numberList {
        sum += number
    }
    return sum / Double(numberList.count)
    
}

mean(12342.342, 123, 45.78, 100)
//
//In-Out parameters

//The inout keyword indicates an explicit intent to modify the arrays
func swapArrays(_ firstArray: inout Array<Int>, _ secondArray: inout Array<Int>) {
    //Temp array to hold the firstArray value
    let tempArray = firstArray
    //First swap
    firstArray = secondArray
    //Second swap
    secondArray = tempArray
    
    print(firstArray, secondArray)
    
}
var firstArray = [1,2,3]
var secondArray = [4,5,6]
//Explicit & also indicates that the values will be changed
swapArrays(&firstArray, &secondArray)
//
//Function Types
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

//Can assign function types to a variable, and use them to refer to the fucntion
let mathfunction: (Int, Int) -> Int = addTwoInts
mathfunction(2,3)

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//Swift can infer the function type when assigning function to the variable
let anotherMathFunction = multiplyTwoInts

anotherMathFunction(2,6)

//
//Function Types as Paramter Types

func addTwoStrings(_ a: String, _ b: String) -> String {
    return a + b
}

//Pass any function of that type as the argument for the first parameter
func wordFunction(_ stringFunction: (String, String) -> String, _ stringOne: String, _ stringTwo: String) {
    print(stringFunction(stringOne, stringTwo))
}
//This leaves some aspects of a function's implementation for the function's caller to provide
wordFunction(addTwoStrings(_:_:), "This is a test", " for adding two strings")

//
//Function Types as Return Types

func incrementOne(_ num: Int) -> Int {
    num + 1
}

func decrementOne(_ num: Int) -> Int {
    num - 1
}

//The function's return type is (Int) -> Int
//Relies on other methods to provide the return value as long as they adhere to the function type
func chooseIncrementDecrement(_ indicator: Bool) -> (Int) -> Int {
    return indicator ? incrementOne : decrementOne
}

var value = 3
//A reference of the returned function is returned to moveToZero
let moveToZero = chooseIncrementDecrement(value > 0)
//Now moveToZero can be used to modify value

//
//NestedFunctions

//An enclosing function can be used to return one of its nested functions
func addStringFunction(_ indicator: Bool) -> (String) -> String {
    func addBacon(_ string: String) -> String { return string + "bacon" }
    func addMayo(_ string: String) -> String { return string + "mayo" }
    
    return indicator ? addBacon : addMayo
}

let stringFunction = addStringFunction(false)

stringFunction("Lettuce")






