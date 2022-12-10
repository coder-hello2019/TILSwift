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

switch testInt {
case 5:
    print("We got 5")
case 1..<5:
    print("We got less than 5")
case 5...100:
    print("We got more than 5 - \(testInt)")
default:
    print("We got a loooot")
}
