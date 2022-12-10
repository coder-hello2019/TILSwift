import Cocoa

/* Fundamentals
 
 Switch statements look at a value and compare it against possible matching patterns / one or more values of the same type. It's similar to an 'if' but there are a few points to note:
    (i) switch statements must be exhaustive so may need to include a 'default' clause if you don't actually want to set out all the cases;
    (ii) there is no implicit fallthrough to the next case, so each case must include some executable statement.
 
 */

var demoString = "hello world"
demoString = "I love baking"

switch demoString {
case "i love baking":
    print("You're a baker")
case "hello world":
    print("You're a programmer")
default:
    print("I've no idea who you are")
}

// switch statements can also cover intervals

var testInt = 1
testInt = 553
testInt = 7

switch testInt {
case 5:
    print("We got a 5")
case 1..<5:
    print("We got less than 5")
case 6, 7, 8:
    print("We got either 6 or 7 or 8")
case 8...100:
    print("We got more than 5 - \(testInt)")
default:
    print("We got a loooot")
}

// we can use a single switch statement to test multiple values (e.g. if we are using a tuple to store the coordinates of a point on a graph - this example is from the official Swift book)
let demoPoint = (1, 1)
switch demoPoint {
case (0, 0):
    print("\(demoPoint) is at the origin")
case (_, 0):
    print("\(demoPoint) is on the x-axis")
case (0, _):
    print("\(demoPoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(demoPoint) is inside the box")
default:
    print("\(demoPoint) is outside of the box")
}

// value bindings / temporary constants - these allow you to use the contents of a case inside that case's statement
let anotherPoint = (7, 0)
switch anotherPoint {
// this declares a temp constant x, being the first item in the anotherPoint tuple
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
    
// we could also deal with x without declaring the constant as per the commented out code below
//case(_, 0):
//    print("on the x-axis with an x value of \(anotherPoint.0)")
    
case (0, let y):
    print("on the y-axis with a y value of \(y)")
// note the lack of a default case because let (x, y) is exhaustive on its own, so there's no need for a default
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// we can also add 'where' clauses to introduce additional conditionality to switch statements

let anotherDemoPoint = (1, 1)
let demoBool = false

switch anotherDemoPoint{
// note that we can be checking multiple conditions inside the switch - demoBool is defined outside anotherDemoPoint, but it can still be factored into the where clause
case let (x, y) where (x == y) && (demoBool):
    print("The point is on the line x = y")
case let (x, y) where x == -y:
    print("The point is on the line x = -y")
case let(x, y):
    print("The point is on some other line")
}

