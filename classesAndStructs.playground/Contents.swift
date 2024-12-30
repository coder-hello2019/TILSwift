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

// MARK: CLASSES

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

// class inheritance often spans many levels, e.g.
// the 'final' keyword here also means that this class can't be subclassed; there are various reasons why you might want to prevent subcalssing e.g. if multiple ppl are working in the code and you're worried that they might break things by subclassing
final class HistoricWorldChamption: WorldChampion {
    var seasons: [String]
    
    init(name: String, racingNumer: Int, numOfTitles: Int, seasons: [String]) {
        self.seasons = seasons
        super.init(name: name, racingNumber: racingNumer, numOfTitles: numOfTitles)
    }
}

var lauda = HistoricWorldChamption(name: "Lauda", racingNumer: 1, numOfTitles: 4, seasons: ["1981", "1983"])
lauda.seasons

/*
 As flagged above, it is key to remember that classes are reference types (think pointers in C) so copies of a class share its data. The example below illustrates this.
 This is also the reason for classes having de-initialisers. Things could get confusing without them, given that everything points to the same underlying data.
 */

var hunt = lauda
hunt.numOfTitles

hunt.numOfTitles = 1

hunt.numOfTitles
lauda.numOfTitles

// MARK: STRUCTS

// demo struct for an F1 driver which has properties for the driver's name and the position they finished this season - note the lack of an initialiser here
struct F1Driver {
    var name: String
    var finishedSeason: Int
}

var ver = F1Driver(name: "Verstappen", finishedSeason: 1)
var per = ver

per.name

per.name = "Perez"
per.finishedSeason = 3

print("ver.name: \(ver.name), ver.finishedSeason: \(ver.finishedSeason)")
print("per.name: \(per.name), per.finishedSeason: \(per.finishedSeason)")


