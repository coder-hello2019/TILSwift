import Cocoa

/* Foundations
 A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. Protocols therefore let us define how structs, classes and enums ought to work and enforces compliance (protocols are said to be 'adopted' by structs/classes/enums). They're effectively a way to extract common functionality of structs/classes/enums into one place and then apply it to custom structcs/classes/enums as needed.
 
 Think of a protocol like the 'lowest common denominator' for multiple structs/classes/enums.

Defining a protocol - note that:
(i) property requirements are always defined as variable properties,
(ii) gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get } (only using { get } doesn't mean that the property has to be gettable-only, just that it CAN be gettable-only},
(iii) protocols can require that object conforming to them have / use specific methods - see example below.
 
 */

// MARK: PROTOCOLS

// defining protocols - here is one that requires that the object conforming to it have title and author properties and have a method that returns nil
protocol BookProtocol {
    var title: String {get set}
    var author: String {get set}
    
    func readMe() -> ()
}

// each struct created using the protocol must contain the title and author fields but they can have properties on top of these two
struct Biography: BookProtocol {
    var title: String
    var author: String
    var yearPublished: Int
    
    func readMe() -> () {
        print("You're reading a biography")
    }
}

struct Textbook: BookProtocol {
    var title: String
    var author: String
    var subject: String
    
    func readMe() -> () {
        print("You're reading a textbook")
    }
}

func read(book: BookProtocol) {
    print("I'm reading \(book.title)")
}

var demoBook1 = Biography(title: "Steve Jobs", author: "Walter Isaacson", yearPublished: 2011)
var demoBook2 = Textbook(title: "Algorithms", author: "Sedgwick", subject: "computer science")

// the read() function can take anything that conforms to BookProtocol as its arguments, so we can use it on both the Biography and TextBook structs
read(book: demoBook1)
read(book: demoBook2)

demoBook1.readMe()
demoBook2.readMe()

// we can also have 'protocol compisions' i.e. a mechanism that applies the combined requirements of multiple compositions. Let's add a new Ebook protocol to explore how protocols can be combined.
protocol EBook {
    var publisher: String {get set}
}

struct KindleBook: BookProtocol, EBook {
    var title: String
    var author: String
    var publisher: String
    
    func readMe() {
        print("read me")
    }
}

// this function takes parameters that conform to the protocol composition of BookProtocol & EBook

func readEBook(ebook: BookProtocol & EBook) {
    print("I'm reading \(ebook.title) published on \(ebook.publisher)")
}

var demoKindle = KindleBook(title: "Deep Work", author: "Cal Newport", publisher: "kindle")
readEBook(ebook: demoKindle)

demoKindle.readMe()



/* Protocol inheritance
 
 Helpful if we want to combine functionality for common work e.g. a 'computer' protocol (that covers all PCs) will have CPU and memory parameters, but a 'laptop' protocol may need both of these properties PLUS a screen size property.
 
 */

protocol Computer {
    var memory: Int {get}
    var cpu: String {get set}
}

protocol Laptop: Computer {
    var screenSize: Int {get set}
}

struct MacBook: Laptop {
    var screenSize: Int
    var memory: Int
    var cpu: String
}

var air = MacBook(screenSize: 13, memory: 256, cpu: "M1")
air.cpu


// MARK: EXTENSIONS

/*
 Extensions allow us to modify types we don't own (e.g. created by Apple) to adapt and conform to a new protocol. This is how we would do this:
 */

// a struct that doesn't conform to Computer - for the sake of argument, let's assume that we wouldn't normally have access to this
struct NotAComputer {
    var name: String
}

// extension to NotAComputer to make it conform to Computer - note that WE CAN ONLY EXTENT STRUCTS FOR COMPUTED PROPERTIES, NOT STORED PROPERTIES
extension NotAComputer: Computer {
    var memory: Int {
        get {
            return self.name.count
        }
    }
    var cpu: String {
        get {
            return self.name
        }
        set {
            name = newValue
        }
    }
    
}

// note that we now declare NotAComputer just with its original property 'name', but it also has the computed properties of 'memory' and 'cpu'
var demoNotAComputer = NotAComputer(name: "I'm not a computer")
demoNotAComputer.memory
demoNotAComputer.cpu

demoNotAComputer.name = "hey"
demoNotAComputer.memory
demoNotAComputer.cpu

/*
 Extension example not involving a protocol but using one of Apple's own types
 */

// We can also do this with Apple's existing types, like so:
extension Int {
    
    func squared() -> Int {
        return self * self
    }
}

var testInt = 5
testInt.squared()

// we can make this broader by making the .squared() function apply to all Numeric types

extension Numeric {
    // the reference to capitalised 'Self' here means that we'll be returning output of the type that is passed in; this is so that the function can cater for both Ints and Doubles
    func squared() -> Self {
        // the lowercase self here just refers to 'whatever input this function was applied to'
        return self * self
    }
}

var testNumericInt = 5
testNumericInt.squared()

var testNumericDouble = 4.0
testNumericDouble.squared()

extension String {
    func makeChristmasy() -> String {
        var returnString: String = ""
        for character in self.lowercased() {
            returnString.append(String(character) + " HO! ")
        }
        return returnString
    }
}

var testString = "hello world"
testString.makeChristmasy()
