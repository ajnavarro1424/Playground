//MARK: - Initialization
//Initialization is the process of preparing an instanc eof a class, struct, or enum. The process involves setting an initial value for each stored property and any other setup
//Special methods called "initializers" are used. Swift initializers return no value

//Instances of class types can also implement a deinitializer, which performs custom cleanup just before the instance of that class is deallocated.

//MARK: - Settting Initial Values for Stored Properties
//Classes and structures MUST set all their stored properties to an appropriate initial value. Stored properties cannot be left in an indertminate state.

//Set an initial value for a stored property within an initializer, or by assigning a default property value as part of the definition
struct Fahrenheit {
    var temperature: Double
    //In its simplist form, an initializer is like an instance method with no parameters
    init() {
        temperature = 32.0
    }
}
let f = Fahrenheit()
f.temperature

//Default Property Values
//Aternative to an initializer, you can specify a default property value as part of the property's declaration
struct FahrenheitTwo {
    var temperature = 32.0
}

//MARK: - Customizing Initialization
//Initialization Parameters
//Initialization parameters have the same capabilities and syntax as function and method parameters
struct Celsius {
    var tempCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        tempCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        tempCelsius = kelvin - 273.15
    }
}

//Parameter Names and Argument Labels
//The names and types of an initializer's parameters play particularly important role in identifying which initializer should be called.
//Swift provides an automatic argument label for every parameter in an initializer if one is not provided
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
//Argument labels must be used in the initializer call
let color = Color(red: 0.5, green: 0.76, blue: 0.45)

//Initializer Parameters without Argument Labels
//You can write an underscore instead of an explicit argument label for that parameter
struct CelsiusTwo {
    var celsiusTemp: Double
    init(_ celsius: Double) {
        celsiusTemp = celsius
    }
}
//The call to CelsiusTwo initializer is clear in its intent wihtout an argument label
let celsiusTwo = CelsiusTwo(45.0)

//Optional Property Types
//If a stored property value is logically allowed to have "no value", declare as an optional type
//Optional stored properties are initialized to a value of nil
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let tacoQuestion = SurveyQuestion(text: "Do you like tacos")
tacoQuestion.ask()

//Assigning Constant Properties During Initialization
class SurveyQuestionTwo {
    //Constant indicates the question cannot be changed
    let text: String
    var response: String?
    //The initializer can still set the value of the declared constant
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let burritoQuestion = SurveyQuestion(text: "Do you like burritos?")

//MARK: Default Initializers
//Any struct or class that provides default values for all properties gets a "default initializer"
struct Mouse {
    let legs = 4
    let small = true
    var isDead: Bool?
}
//All properties have default values and because Mouse is a base class, the class gains a default initializer
let mouse = Mouse()

//Memberwise Initializers for Structure Types
//Structure Types automatically receive a "memberwise initializer" if they don't define any of their own custom initializers(even if they properties don't have default values)
struct Size {
    var width = 0.0, height = 0.0
}
//The Size struct automatically receives a memberwise initlizier
let size = Size(width: 500, height: 650)
//Calling a memberwis initialier, you can omit values for any properites that have default values
let zeroByTwo = Size(height: 2.0)

//MARK: - Initializer Delegation for Value Types
//Initliazers can call other initializers to perform part of an instance's initlization. This is known as initializer delegation, and avoids duplicating code across multiple initializers.
//Value types do not support inheritance, so they can only delegate to another initializer that they provide themselves.
//Classes have additional responsibilites for ensuring that all stored properties they inherit are assigned a value

//Reference the code above for Size
struct Point {
    var x = 0.0, y = 0.0
}
//Rect structure below has three potential initializations:
struct Rect {
    var origin = Point()
    var size = Size()
    // Using its default zero-initialized property values
    init() {}
    // By providing a specific origin point and size
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    // Or by providing a specific center and size. This delegates to the other initializer when origin coords are calculated.
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}
let basicRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 3.0), size: Size(width: 5.0, height: 5.0))

//MARK: - Class Inheritance and Initialization
//All of a class's stored properties - including any properties the class inherits from its superclass -- must be assigned an initial value during initialization

//Designated Initializers and Convenience Initializers
//Designated Initializers: Primary initializers for a class. A designated initializer fully initializes all properties introduced by the class, and calls superclass initializers
//Convenience Initializers: Secondary, supporting intializes for a class. You can call a designated initializer from the same class as the convenience initializer. Convenience initializers can be used for a specific use case for the instance

//Initializer Delegation for Class Types
//Rule 1: A designated initializer must call a designated initializer from its immediate superclass
//Rule 2: A convenience initializer must call another initializer from the same class
//Rule 3: A convenience initializer must ultimately call a designated initializer.
//TLDR: Designated initializers must always delegate up / Convenience intializrs must always delegate across.

//Two-Phase Intialization
//First phase, each stored property is assigned an initial vlaue by the class that introduced it.
//Second phase, and each class is given the opportunity to customize stored properties

//Initializer Inheritance and Overriding
//Swift subclasses do not inherit their superclass initializers by default. This prevents a generalized superclass from initializing a more specialized subtask
//If you write a subclass initializer that matches a superclass desginated initializer, you are overriding the superclass initializer
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}
//Vehicle provides value for only stored property, so it receives default initializer
let vehicle = Vehicle()

class Bicycle: Vehicle {
    //Bicycle defines a custom designated initializer that matches the superclass default initializer
    override init() {
        //superclass initializer is called to make sure property is initialized before modification
        super.init()
        numberOfWheels = 2
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        //super.init called implicitly here
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}
//hoverboard still has numberOfWheels property set, even though super.init was never explicitly called.
let hoverboard = Hoverboard(color: "blue")
print(hoverboard.description)

//Automatic Initializer Inheritance
//Subclasses do not inherit their superclass initializers by default.
//Assuming you provide default values for any new properties you introduce in a subclass the following rules apply:
//Rule 1: If the subclass doesn't define any designateed initializers , it automatically inherits all of the super class designated initializers
//Rule 2: If the subclass provides an implementation of ALL its superclass designated initializers(by inheriting them) or by providing custom implementation, then the subclass automatically inherits all of the superclass convenience initializers.

//Designated and Convenience Initializes in Action

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}
//Classes do not have a default memberwise initializers, so the Food class provides a designated initializer.
let namedMeat = Food(name: "Bacon")

class RecipeIngredient: Food {
    var quantity: Int
    //Designated initializer which populates all of the properties by delegating up to the superclass initializer
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    //Convienence initializer delegates across to the class's designated initialzer. It must be marked with "override" because it has the same parameters as Food's designated initializer
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
//All three initializers can be used for RecipeIngredient:
//Food convenience initializer:
let oneMysteryItem = RecipeIngredient()
oneMysteryItem.quantity
oneMysteryItem.name
//RecipleIngredient overriding convenience initializer
let oneBacon = RecipeIngredient(name: "Bacon")
oneBacon.quantity
oneBacon.name
//RecipleIngredient designated initializer
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
sixEggs.quantity
sixEggs.name

//MARK: - Failable Initializers
//Useful to define a class, structure, or enum for which initialization can fail. Triggerd by invalid parameter values, required external resource, etc.
//Use a "?" after the init keyword
//Cannot define a failable and nonfailable initializer with the same parameter types and names
//A failable initializer creates an optional value of the type it initializes(it will return nil".

//Failable initializers are implemented for numeric type conversions
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}

let valueChanged = Int(exactly: pi)
//valueChanged is of type Int?, not Int

struct Animal {
    let species: String
    init?(species: String) {
        //Failable initializer checks if the species value is empty
        if species.isEmpty { return nil }
        self.species = species
    }
}
let emptyAnimal = Animal(species: "")
if emptyAnimal == nil { print("emptyAnimal is nil") }

//Failable Initializers for Enums
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    //The failable initializer can then fail if the provided prarameters do not match an enum case.
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}
//Failable Initializers for Enums with Raw Values
//Enums with raw values automatically receive a failable initializer.
enum TemperatureUnit2: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}
let unknownUnit = TemperatureUnit2(rawValue: "X")
//unknownUnit is nil

//Propagation of Initialization Failure
//A failable initializer of a class, struct, or enum can delegate across to another failable initializer within the same unit. Subclass failalbe initializer can delegate up to a superclass initializer.
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil}
        self.name = name
    }
}
class CartItem: Product {
    let quantity: Int
    //If quantity is invalid, the entire initialization process fails
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil}
        self.quantity = quantity
        super.init(name: name)
    }
}
//Overriding a Failable Initializer
//You can overrride a superclass failable initializer in a subclass.
//Additionally, you can overrirde a superclass failable initializer with a subclass nonfailable initializer
class Document {
    var name: String?
    //Initializer creates a nil name value
    init() {}
    //Initializer creates a nonemtpy name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
        
    }
}
//AutomaticallyNamedDocument overrides both of the designated initializers of Document. This ensures that an Automatically named document always has a consistent name
class AutomaticallyNamedDoc: Document {
    //Instead of nil name value, place "Untitled"
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        //Instead of nil Document, rename to "Untitled"
        if name.isEmpty {
            self.name = "[Untitled]"
        }
        else {
            self.name = name
        }
    }
}

// MARK: - Required Initializers
//"required" modifier before the definition of a class initializer means that every sublcass of the class must implment it
class SomeClass {
    required init() {
    }
}
//"required" modifier before every subclass implementation of a required initializer.
class SomeSubClass: SomeClass {
    required init() {
        //subclass implementation of a required initializer goes here
    }
}




