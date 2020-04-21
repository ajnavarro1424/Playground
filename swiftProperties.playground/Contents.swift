// MARK: - Properties

//Stored properties store constant and variable values as part of an instance (Classes/Structs)
//Computed properties calculate(rather than store) a value. (Classes/Structs/Enums)
//Define property observesrs to monitor changes in a property's value

// MARK: - Stored Properties

//Simplist form = constant or variable that is sotred as part of an instance(class or struct)

struct FixedLengthRange {
    var firstValue : Int
    let length: Int
}
//Constant properties cannot be changed after initialization: "length"
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

//Stored Properties of Constant Structure Instances
//Instances of structs assigned to a CONSTANT are not modifiable
let rangefOfFiveItems = FixedLengthRange(firstValue: 123, length: 5)
//This is due to structures being VALUE TYPES, when instance is declared as a constant, so are its properties


//Lazy Stored Properties
//A property whose initial value is not calcualted until the first time it is used.
//Constant props cannot be "lazy" because they must have a value before initialization

//Useful for when the value is dependent on other factors, or computationally intensive to calculate.

class DataImporter {
    var filename = "data.txt"
    //Assume complexity/time in importing data from the data file
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some new data")
//DataImporter instance for the importer property has not been created, until is is needed when "importer" is used.

//MARK: - Computed Properties

//Provide a getter and an optional setter to retrieve ans et other properties and values indirectly
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rectangle{
    var origin = Point()
    var size = Size()
    //Computed Property which calculates the center of the rectangle
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        //Resets origin when new center is passed
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
//Create a square
var square = Rectangle(origin: Point(x: 0.0, y: 0.0), size: Size(width: 5, height: 5))
//Calcualte the center using computed center property
let InitialSquareCenter = square.center

//Set a new origin using computed center setter
square.center = Point(x: 10, y: 10)
print("The origin of the new square is: \(square.origin.x), \(square.origin.y)")

//Shorthand Setter Declaration
struct AlertnativeRectangle {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
        }
        //If setter doesn't define a name for thenew value to be set, a default name of "newValue" is used
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//Read-Only Computed Properties
//A computed property with a getter but no setter is known as a "read-only" computed property
//Computed properties must always be declared with the "var" keyword
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume : Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4, height: 5, depth: 2)
let cuboidVolume = fourByFiveByTwo.volume


//MARK: - Property Observers
//Property observers observe and respond to changes ina  propert's value
//Property observers are called every time a property's value is set, regardless of the current value

//"willSet" is called just before the value is stored. Passed the new property value as a constant(uses "newValue" as default name)

//"didSet" is called immediately after the new value is stored. Passed the old property value as a constant(uses "oldValue" as a default name)

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
            
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 234


//MARK: - Property Wrappers
//Property warpper adds a layer of separation between cod ethat manages how a property is stored and the code that defines a property.
//Write the managemet code oonce when you define the wrapper, and reuse that management code by applying it to properties

@propertyWrapper
struct TwelveOrLess {
    private var number : Int
    init() {
        self.number = 0
    }
    var wrappedValue : Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
var newNumber = TwelveOrLess()
newNumber.wrappedValue = 234
newNumber.wrappedValue

//Apply the TwelveOrLess property wrapper to a property
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rect = SmallRectangle()
rect.height = 34

//Setting Initial Values for Wrapped Properties
//Property wrappers needs an initializer to be able to set inital values for wrapped properties
@propertyWrapper
struct SmallerThanMax {
    private var number : Int
    private var max : Int
    
    var wrappedValue: Int {
        get { return number }
        set (newNumber) { number = min(newNumber, max) }
    }
    //Normal initializer
    init() {
        number = 0
        max = 12
    }
    //Initializer with wrappedValue
    init(wrappedValue: Int) {
        max = 12
        number = min(wrappedValue, max)
    }
    //Initializer with wrappedValue and max
    init(wrappedValue: Int, max: Int) {
        self.max = max
        number = min(wrappedValue, max)
    }
}

struct UnitRectangle {
    //Most General Syntax
    //By including arguments to the property wrapper, you can setup the initial state in the wrapper, or pass other otpions
    @SmallerThanMax(wrappedValue: 5, max: 7) var height: Int
    @SmallerThanMax(wrappedValue: 9, max: 10) var width: Int
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)

//Projecting a Value From a Property Wrapper
//Expose additional functionality by defining a "projectedValue"
//Same name as the wrapped value, but uses a "$"

//MARK: - Global and Local Variables

//Global variables are defined outside of any function, method, closure, or type context. ALWAYS computed lazily, like lazy stored properties
//Local variables are defined inside those structurese

//MARK: - Type Properties
//Instance properties are properties that belong to an instance of a particular type
//Type properties belong to the type itself, not to any one instance(only one copy)

//Useful for defining values that are universal to all instances of a particular type
//Must always give a default value for type properties
//Lazy initialized upon their first access

//Type Propety Syntax
//Written as part of the type's definition using the "static" keyword
struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

class SomeClass {
    static var storedTypeProperty = "Some other value"
    static var computedTypeProperty: Double {
        return 12345.6789
    }
    //Computed type properties for class types, you can use the "class" keyword instead to allow subclasses to override the superclass
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//Querying and Setting Type Properties
//Type properties are queried and set on the type, not on an instance of that type.
SomeStructure.storedTypeProperty
SomeStructure.storedTypeProperty = "Some different value"
SomeClass.computedTypeProperty


//MARK: - Personal Questions

//Computed properties with optional "setters" must back calculate the other variables that lead to its value
struct Water {
    var bottles = 12.55
    var bottleSize = 12.3
    var waterWeight: Double {
        get { bottles * bottleSize }
        set(newWaterWeight) {
            //Assume 1L bottleSize
            bottleSize = 1
            bottles = newWaterWeight / bottleSize
        }

    }
}
var water = Water()
water.waterWeight
water.waterWeight = 666
print(water.waterWeight)
print(water.bottles)
print(water.bottleSize)
