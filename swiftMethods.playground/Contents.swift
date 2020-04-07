//MARK: - Methods

//Methods are functions that are associated with a particular type. Classes, structures, and enums can all define instance methods, which encapsulate specfiic functionality when working with an instance.
//Structs ad enums can define methods in Swift

//MARK: - Instance Methods
//Instance methods are functions that belong to instances of a particular class, struct, or enumeration.
//Instance methods has implicit access to all other instance methods and properties of that type

class Counter {
    var count = 0
    func increment() {
        self.count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
//Calling the instance methods
counter.increment()
counter.increment(by: 100)
counter.reset()

//The self Property
//Every instance of a type has an implicit property called "self", which is equivalent to the instance itselfj
//Generally you don't need to use "self", unless the parameter name for an instance method = same name as property

struct Point {
    var x = 0.0, y = 0.0
    
    func isToTheRightOf(x: Double) -> Bool {
        //Parameter name "x", matches property name "x", so self is explicit
        return self.x > x
    }
    
}

//Modifying Value Types from Within Instance Methods

//Structs and enums are value types. By default, the properies of a value type cannot be modified from within its instance methods
//Use "mutating" keyword to mutate struct/enums properties that are written back to the original structure
struct AnotherPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(_ deltaX: Double, _ deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var point = AnotherPoint()
//Modifies the point on which it is called
point.moveBy(5, 123)
point.x
point.y

//"mutating" methods can also assign a completely new instance to its implicit "self" property, where the new instance will replace the existing one.
struct SomePoint {
    var x = 0.0, y = 0.0
    mutating func shiftBy(_ deltaX: Double, _ deltaY: Double) {
        self = SomePoint(x: x + deltaX, y: y + deltaY)
    }
}

//Mutating methods for enums can set the implicit "self" parameter to be a different case from the same enumeration
enum TripleStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TripleStateSwitch.low
ovenLight.next()
ovenLight.self

//MARK: - Type Methods
//You can also define methods that are called on the type itself.
//Type methods are written using the "static" keyword.
//Type methods are called on the type, not an instance of that type

//Classes can use the class keyword instead, to allow subclasses to override the superclass’s implementation of that method.
class SomeClass {
    class func someTypeMethod() {
        //Within the body of a type method, "self" refers to the type itself
    }
}
SomeClass.someTypeMethod()


