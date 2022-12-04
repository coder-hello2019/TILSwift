import Cocoa

/* Foundations
 A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. Protocols therefore let us define how structs, classes and enums ought to work and enforces compliance (protocols are said to be 'adopted' by structs/classes/enums). They're effectively a way to extract common functionality of structs/classes/enums into one place and then apply it to custom structcs/classes/enums as needed.
 
 Think of a protocol like the 'lowest common denominator' for multiple structs/classes/enums.
 
 */

// MARK: PROTOCOLS

// define a protocol - note that (i) property requirements are always defined as variable properties and (ii) gettable and settable properties are indicated by writing { get set } after their type declaration, and gettable properties are indicated by writing { get } (only using { get } doesn't mean that the property has to be gettable-only, just that it CAN be gettable-only}.
protocol BookProtocol {
    var title: String {get set}
    var author: String {get set}
}

// each struct created using the protocol must contain the title and author fields but they can have properties on top of these two
struct Biography: BookProtocol {
    var title: String
    var author: String
    var yearPublished: Int
}

struct Textbook: BookProtocol {
    var title: String
    var author: String
    var subject: String
}

func read(book: BookProtocol) {
    print("I'm reading \(book.title)")
}

var demoBook1 = Biography(title: "Steve Jobs", author: "Walter Isaacson", yearPublished: 2011)
var demoBook2 = Textbook(title: "Algorithms", author: "Sedgwick", subject: "computer science")

// the read() function can take anything that conforms to BookProtocol as its arguments, so we can use it on both the Biography and TextBook structs
read(book: demoBook1)
read(book: demoBook2)


/* Protocol inheritance
 
 Helpful if we want to combine functionality for common work e.g. a 'computer' protocol (that covers all PCs) will have CPU and memory parameters, but a 'laptop' protocol may need both of these properties PLUS a screen size property.
 
 */

protocol Computer {
    var memory: Int {get set}
    var cpu: String {get set}
}

protocol Laptop: Computer {
    var screenSize: Int {get}
}

struct MacBook: Laptop {
    var screenSize: Int
    var memory: Int
    var cpu: String
}

var air = MacBook(screenSize: 13, memory: 256, cpu: "M1")
air.cpu




// MARK: EXTENSIONS
