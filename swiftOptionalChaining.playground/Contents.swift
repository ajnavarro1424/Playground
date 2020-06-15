// MARK: Optional Chaining
// Optional chaining is a process for querying and calling props, methods, and subscripts on an optional that might be nil.
// Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nill

//Optional Chaining as an Alternative to Forced Unwrapping
//Specify optional chaining by placing a question mark "?" after the optional value
//Result of a chaining call is always an optional value even if the prop, method, or subscript you are querying is non-optional
class Person {
    var residence: Residence?
}
class Residence {
    var numberOfRooms = 1
}
//residence property is initialized to nil
let john = Person()
//force unwrapping residence causes a runtime error because residence is nil
//let roomcount = john.residence!.numberOfRooms

//roomCount is an Int?
//Not that this is true even though numberOfRooms is non-optional Int
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

//Now that john.residcen contains an actual Residence instance, numberOfRooms will return 1(Int?)
john.residence = Residence()

//Defining Model Classes for Optional Chaining
//Use optional chaining with calls that are more than one level deep.
//This enables you to drill down into subproperties wihtin complex models of inter-related types, and check whether it is possible to access these items

class Person2 {
    var residence: Residence2?
}

class Residence2 {
    var rooms = [Room2]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room2  {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address2?
}
class Room2 {
    let name: String
    init(name: String) {
        self.name = name
    }
}
class Address2 {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    //Checks the properties of the address and returns buildingName or buildingNumber/street
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

//Accessing Properties Through Optional Chaining
let john2 = Person2()
//Access the numberOfRooms property as before through optional chaining
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("John does not have a residence.")
}
//Try to set a property's value through optional chaining:
let someAddress = Address2()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
//The attempt to set the address property of john.residence will fail because it is nil
john2.residence?.address = someAddress
//Its hard to see that the assignment fails because accessing a constant doesn't have any side effects

//If you use a function to create the address, the function can give more context before returning a value
func createAddress() -> Address2 {
    print("creatAddress function ws called")
    let someAddress =  Address2()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    return someAddress
}
//The below statement show nothing is called, because nothing is printed
john2.residence?.address = createAddress()

//Calling Methods Through Optional Chaining
//You can use optional chaining to call a method on a optional value, and check whether that method call is successful
//The printNumberOfRooms() method does not specify a return type, but returns a value of "Void". This means they return the value of (), or an empty tuple
//Compare the return value of from the call against nil to see if the call was successful
if john2.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
//The same can be done for any attempt to set a property through optional chaining. Just check for nil

//Accessing Subscripts Through Optional Chaining
//When you access a subscript on an optional value through optional chaining, you place the question mark before the brackets
if let firstRoomName = john2.residence?[0].name {
    print("The first room name is \(firstRoomName)")
}

//Accessing Subscripts Through Optional 
