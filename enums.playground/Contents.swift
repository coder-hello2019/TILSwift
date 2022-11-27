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


// iterating over enum cases

// raw values

