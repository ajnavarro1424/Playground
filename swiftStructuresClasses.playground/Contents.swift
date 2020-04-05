// MARK: - Structures and Classes

//Definition Syntax
//Define a struct or class, you define a new Swift Type
//Give types "UpperCamelCase" names
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var framrate = 0.0
    var name: String?
}

//Structure and Class Instances
let someResolution = Resolution()
let someVideoMode = VideoMode()

//Accessing Properties
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is \(someVideoMode.resolution.width)")

//Memberwise Initializiers for Struture Types
//All structures have an automatically generated "memberwise initializers"
//Class instances DONT receive a default memeberwise initializer
let vga = Resolution(width: 640, height: 480)

// MARK: - Structures and Enumerations are Value Types
//A value type is a type whose value is copied, to create a local unique value(Ints, FP Numbers, Bool, Strings, Arrays, Dictionaries)
//Structures and Enumerations are value types
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048

//Two completely separate structure instances
print("cinema  is now \(cinema.width)")
print("hd is still \(hd.width)")

//Enums have the same behavior
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
//currentDirection and rememberedDirection are value types and copy their local values
var currentDirection = CompassPoint.south
let rememberedDirection = currentDirection
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

//MARK: - Classes are Reference Types

//Reference types make a reference to the same exsisting instance

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.framrate = 25.0

//Because classes are reference types, both contsants refer to the same VideoMode instance
let alsoTenEighty = tenEighty
alsoTenEighty.framrate = 30.0
print("The framerate of of tenEighty is: \(tenEighty.framrate)")
//Even though tenEighty and alsoTenEighty are constants and do not change.
//Instead they REFER to a instance of VideoMode that has changed.

//Identity Operators

//Its possible for multiple constants and variables to refer to the same single instance of a class
//Identical to (===)
//Not identical to (!==)

//Check to see if they refer to the same class instance(identical)
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

//Identical means that two constants or variables of class type refer to exactly the same class instance
//Equal to means that two instances are considered equal or equivalent in value.

//When defining your own custom structures and classes, it's your responsiblity to decide what qualifies as two instances being equal
