// MARK: - Deinitialization
// A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the "deinit" keyword. Only available on class types

// MARK: - How Deinitialization Works
//Swift automatically deallocates your instances when they are no longer needed.
//Handled through automatic reference counting(ARC)
//When working with your own resources, you might need some additional cleanup(File opening/closing)
class SomeClass {
    init() {
        //perform initialization
    }
    //One deinitializer per class. No parameters
    deinit {
        //perform deinitialization
    }
}
//Deinitializers are called automatically, so they cannot be called manually.
//A deinitializer can access all the properties of the instance in order to do cleanup.

// MARK: - Deinitiailzers in Action
class Bank {
    //type property
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int{
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    //Deinitializer returns all of the player's coints to the bank when the instance is no longer valid
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 200)
playerOne!.win(coins: 500)
print("Player One: \(playerOne!.coinsInPurse)")
print("Bank: \(Bank.coinsInBank)")
//Setting the optional playerOne variable to nil breaks the variables reference to the Player instance.
playerOne = nil
print("Bank: \(Bank.coinsInBank)")
