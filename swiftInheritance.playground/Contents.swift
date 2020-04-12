//MARK: - Inheritance
//A class can inherit methods, properties, and other characteristics from another class.
//Ensure overrides are correct by checking that the override definiton has matching superclass definition
//Add property observers to inherited properties in order to be notifed when the value changes, regardless if its defined as a stored or computed property

//MARK: - Defining a Base Class
//Any class that does not inherit = "base class"
//Swift classes do not inherit from a universal base class
class Vehicle {
    var currentSpeed = 0.0
    //Computed property utilizing currentSpeed
    var description: String {
        "Traveling at \(currentSpeed) miles per hour"
    }
    //Method makeNoise will be customized by subclasses
    func makeNoise() {}
}

let someVehicle = Vehicle()
someVehicle.description

//MARK: - Subclassing
//Subclassing is the at of basing a new class on an existing class.
//The new Bicycle class automatically gains all of the characteristics of Vehicle
class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
bicycle.description

//Subclasses can themselves be subclassed.
class Tandem: Bicycle {
    var currentNumberOfPassenders = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassenders = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")

//MARK: - Overriding
//A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript
//"override" keyword is necessary, diagnosed as an error when your code is compiled

//Accessing SuperClass Methods, Properties, and Subscripts
//Useful to use the exsiting superclass impementation as part of the override.
//An overriden method named someMethod() can call the superclass version of someMethod(0 by calling super.someMethod() within the overriding method implementation

//Overriding Methods
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo!")
    }
}
let train = Train()
train.makeNoise()

//Overriding Properties
class ElectricBike: Vehicle {
    override var description: String {
        "Traveling at \(currentSpeed) electric miles per hour"
    }
}

let electricBike = ElectricBike()
electricBike.description

//MARK: - Overriding Property Getters and Setters
class Car: Vehicle {
    var gear = 1
    //Calls super.description to return the superclass description
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

//MARK: - Overriding Property Observers
//You can add property observers to an inherited property.
//This enables you to be notifed when the value of an inherited property changes.
class AutomaticCar: Car {
    override var currentSpeed: Double {
        //Whenver you set the currentSpeed property, the property's didSet observer sets the instance's gear property to an appropriate gear
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 70
print("Automatic Car: \(automatic.description)")

//MARK: - Preventing Overrides
//Prevent a method, property, or subsscript from being overriden by marking it as "final"
//Methods, properties or subscripts that you add to a class in an extension can also be marked "final"
class Home {
    final var rooms: Int = 0
    final var bathrooms: Double = 0.0
}

//Mark an entire clas final by writing the final modifier, prevents inheritance
final class Beverage {
    
}

