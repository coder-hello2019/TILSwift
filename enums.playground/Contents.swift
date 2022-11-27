import Cocoa

/* The fundamentals
 
 An enum is just a nice name for a group of values. The official Swift book describes an enum as "a common type for a group of related values". They're helpful, for example, in making code easier to read.
 
 The values defined in an enum are its enumeration 'cases' - as indicated by the 'case' keyword.
 
 Each enum definition defines a new type.
 
 */

// the most basic definition of an enum - note that, like with types in Swift more generally, we capitalise the name. It's also a convention to use a singular name.

enum F1Team {
    case Mercedes
    case RBR
    case Ferrari
    case McLaren
}

// can also define the cases of an enum on a single line
enum SingleLineF1Team {
    case Mercedes, RBR, Ferrari
}

var myFaveTeam = F1Team.McLaren

/* Combining enum cases with a switch statement
 
 A switch statement allows us to run through the possible values / cases of an enum, and do something depending on what value we find. For example - the below text means 'look at the possible values of the myFaveTeam var - if't Mercedes, do this, if's RBR, do that etc.':
    
    Remember that a switch has to be exhaustive so you may need to use the 'default' keyword.
 */

myFaveTeam = .RBR

switch myFaveTeam {
case .Mercedes:
    print("This is the best team")
case .RBR:
    print("This team won the 2022 WDC and WCC")
case .Ferrari:
    print("This team is a meme team")
default:
    print("This team isn't really competitive at all")
}


/* Iterating over enum cases
    
You can treat an enum as a collection of values, which you can iterate over, by making an enum conform to the CaseIterable protocol. You can then access all its cesses as a collection and iterate over them.
 
 */

enum F1TeamCollection: CaseIterable {
    case Mercedes, RBR, Ferrari
}

for team in F1TeamCollection.allCases {
    print("The team is \(team)")
}
print("The number of the teams is \(F1TeamCollection.allCases.count)")


/* Enums and raw values
 
Enum cases can be pre-populated with defalt values, which must all be of the same type.
 
 */

enum F1Points: Int {
    case first = 25
    case second = 18
    case third = 15
}

var Ham = F1Points.first
print("HAM scored \(Ham.rawValue) points")

// When you provide your enum with raw values, the enum (i) is given an initializer, such that you can initialise the enum from a raw value and (ii) turns into an optional (because the initializer may take in a value for which there is no case - see example with unwrapping below).

var Ver = F1Points(rawValue: 15)

if let verPoints = Ver {
    print("VER came \(verPoints) and scored \(verPoints.rawValue) points")
} else {
    print("VER was off the podium")
}



/* Other topics covered in the docs which I've not dug into:
    1. associated values
    2. recursive enums
 
 */
