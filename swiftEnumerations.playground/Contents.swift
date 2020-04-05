import UIKit

//MARK: -Enumeration Syntax
enum someEnumeration {
    //enumeration definition
}

//The values defined in an enumeration are its "enumeration cases"
//Emumeration cases don't have an integer value by default. Instead they are values in their own right, with a defined type of CompassPoint
//Give enumeration types SINGULAR rather than plural names, so they read as self-evident
enum CompassPoint {
    case north
    case south
    case east
    case west
}

//The type of "direction" is inferred when its initialized to one of the possible values of CompassPoint
var direction = CompassPoint.west

//Shorter syntax can be used after the fact
direction = .north

//MARK: -Matching Enumeration Values with a Switch Statement

//Match individual enumeration values with a switch statement. A swtich statement must be "exhaustive" and consider all possible values of CompassPoint
//Default cases can be used to cover for situations where exhaustive lists are inappropriate

switch direction {
case .north:
    print("To the North Pole...")
case .south:
    print("To the Sorth Pole...")
case .west:
    print("To California!")
case .east:
    print("To New York...")
}

//MARK: -Iterating over Enumeration Cases

//Including "CaseIterable" after the enums name exposes a collection of all the cases as an "allCases" property of the enumeration type
enum Beverage: CaseIterable {
    case coffee, soda, water, tea, whiskey, vodkda, seltzer, beer
}

let numberOfBeverages = Beverage.allCases.count
print("The number of beverages is: \(numberOfBeverages)" )

//"allCases" exposes a collection that can be iterated over

for beverage in Beverage.allCases {
    print(beverage)
}

//MARK: -Associated Values

//Associated values are other value types sotred alongside enum case values
//Enum Barcode defines the type of assocaited values that Barcode contstants and variables can store
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(1,2,3,4)
//productBarcode = .qrCode("ABASDFRYUEGRW")

//Case statements can extract associated values
//If all of the associated values are extracted as constants/variables you can use a single let/var respecitvely
switch productBarcode {
case var .upc(numberSystem, manufacturer, product,check):
    print(numberSystem, manufacturer, product, check)
case let .qrCode(productCode):
    print(productCode)
}

//MARK: -Raw Values

//Enumeration cases can come prepopulated with default values(raw values)
//The raw values for ASCIIControlCharacter are defined to be of type Character
//Raw values must be unique within its enum declaration
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//Implicitly Assigned Raw Values
// For Integers, the implicit value for each case is one more than previous
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

let planetNumber = Planet.earth.rawValue

print(planetNumber)

//For Strings, the implicity value is the text of the cases name
enum Sandwhich: String {
    case sandwhich, burger, hotdog, torta
}

let burger = Sandwhich.burger.rawValue
print(burger)


//Initializing from a Raw Value

//The enum automatically recieves an initializer that takes a value of the value's type
let possiblePlanet = Planet(rawValue: 7)
//the raw value initializer returns an optional


//MARK: -Recursive Enumerations

//An enumeration that has another instance of the enumeration as the associated value
//"indirect" indicates the enumeration case is recursive
//

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

//Create an arithmetic expression for "(5+ 4) * 2:
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
