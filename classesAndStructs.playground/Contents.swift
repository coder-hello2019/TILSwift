import Cocoa

/* Fundamentals
 
 Both allow us to create custom types but there are a few key differences:
 * Classes do not come with synthesized memberwise initializers.
 * One class can be built upon (“inherit from”) another class, gaining its properties and methods. (This is actually why classes don't have built-in initialisers - inits could get messy when using inheritance.)
 * Copies of structs are always unique, whereas copies of classes actually point to the same shared data. -> this is why a VM in an app which uses MVVM is normally a class - we need to be able to modify the same underlying from different places
 * Classes have deinitializers, which are methods that are called when an instance of the class is destroyed, but structs do not.
 * Variable properties in constant classes can be modified freely, but variable properties in constant structs cannot.
 
 GENERALLY devs prefer structs - so make sure you have a reason for using a class.
 
 */

// basic example of a class to represent an F1 driver - note the explicit use of an initializer
class Driver {
    var name: String
    var racingNumber: Int
    
    init(name: String, racingNumber: Int) {
        self.name = name
        self.racingNumber = racingNumber
    }
    
    func drive() {
        print("I'm driving")
    }
}

var rus = Driver(name: "Russeel", racingNumber: 63)
rus.name
rus.racingNumber

//class extensions - we can effectively borrom Driver, its properties and methods to create a new class that uses Driver's properties and methods; we call this the subclass of Driver
class BadDriver: Driver {
   // override = 'I know this method was implemented for the parent class but I want to change it for this class'
    override func drive() {
        print("I'm crashing")
    }
}

var latifi = BadDriver(name: "Latifi", racingNumber: 1)
latifi.drive()

/*
 Things get a bit more complex when we want to add properties to a sub-class which aren't in the parent class; recall that Swift wants everything that is not an optional to have a value (and we can't call methods until it does). We need to create a custom initialiser that knows the properties of the parent class and initialises the properties from the parent, while also initialising its own custom property
 
 We achieve this by having a new init for the sub-class which (i) first initialises the properties which are specific to this sub-class, then (ii) calls the initi for the parent class, like so:
 */
class WorldChampion: Driver {
    var numOfTitles: Int
    
    init(name: String, racingNumber: Int, numOfTitles: Int) {
        self.numOfTitles = numOfTitles
        // referring to super basically means 'let my parent class do what it needs to do and I'll just deal with any extra bits'
        super.init(name: name, racingNumber: racingNumber)
    }
}

var ham = WorldChampion(name: "Hamilton", racingNumber: 44, numOfTitles: 7)
ham.numOfTitles


