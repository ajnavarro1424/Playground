import UIKit

//MARK: -Shorter versions of function-like constructs without a full declaration

//The Sorted Method
let names = ["Bob", "Joe", "Mike", "James", "Elizabeth"]

let string1 = "Bob"
let string2 = "Charley"

string1 < string2

//One way to provide the sorting closure is to write a normal function of the correct type, and pass it as an argument to the method.
func alphabetical(_ s1: String, _ s2: String) -> Bool {
    return s1 < s2
}

//var alphabetcalNames = names.sorted(by: alphabetical(_:_:))


//The alphabetical function written as a closure expression instead.

//The in keyword indicates that the definition of the closure's params and return type has finished
var alphabeticalNames = names.sorted(by: {(s1: String, s2: String) -> Bool in
    return s1 < s2})

//MARK: -Inferring Type from Context

//Swift can infer the closure's parameter and return types from the context of the method
var alphaNames = names.sorted(by: {s1, s2 in
    return s1 < s2
})

//MARK: -Implicit Returns from Single-Expression Closures

//Implicit return of the single expression by omitting the "return" keyword
var alphaNames2 = names.sorted(by: {s1, s2 in s1 < s2})
//MARK: -Shorthand Argument Names

//Refer to the values of the closure's arguments by the names of $0, $1, $2
//The "in" keyboard can also be omitted, becasue the closure expression is made up of just the body:
var alphaNames3 = names.sorted(by: {$0 < $1})
//MARK: -Trailing Closures

//Pass a closure expression to a function as the function's final argument
//A trailing closure is written after the function call's parentheses, even tho it still an argument
func someFunctionThatTakesAClosure() {
    //Trailing closure's body goes here
}
//Using the example defined above
var alphaNames4 = names.sorted(){
    $0 < $1
}
//OR omitt the parenthesis of the argument list if the method only accepts a closure
var alphaNames5 = names.sorted {
    $0 < $1
}

//Useful when the closure expression is long
//Example: Map function of Array

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [45, 235, 2429]

//Pass a closure expression to the array's map method as a trailing closure

let strings = numbers.map {(number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}


//MARK: - Capturing Values

//Simplest form is nested function. The nested function can refer to and modify values of the outer function context
func makeDecrementer(forDecrement amount: Int) -> () -> Int {
    var runningTotal = 9990
    //Decrementer captures a reference to runningTotal and amount from the surrounding function.
    func decrementer() -> Int {
        runningTotal -= amount
        return runningTotal
    }
    return decrementer
}

//Constant that refers to the incrementer function
let decrementByTen = makeDecrementer(forDecrement: 10)
//decrementByTen can be called multiple times now
decrementByTen()
decrementByTen()

//MARK: - Closures Are Reference Types

//Functions and closures are reference types
//When a function or clossure is assigned to a constant or variable, you are setting a REFERENCE to that closure

//Multiple assignments reference the same closure
var alsoDecrementByTen = decrementByTen
alsoDecrementByTen()


//MARK: -Autoclosures

//Closure that wraps an expression that's being passed as an argument to a function
//Common to call / Delays evaluation

var customersInLine = ["Chris", "Alex", "Ewa"]
print(customersInLine.count)

//Autoclosure thats created to wrap expression, not evaluated until customerProvider is CALLED
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)

print("Now serving " + customerProvider())
print(customersInLine.count)
