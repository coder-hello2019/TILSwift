import Cocoa

// MARK: this playground purposefully contains some errors/warnings for illustrative purposes

/* Fundamentals
 
 Recap - from memory:
 * Optionals are types which may contain a value or nil - they allow us to represent the absence of data.
 * You need to unwrap optionals - i.e. check whether there is a value or nil - if you try to use nil where your code is expecting an actual value, it will crash your program
    - We do this using the ? operator
 * You can force unwrap optionals (i.e. basically assume that there will be a value) but, generally speaking, you really shouldn't do this because you could end up crashing your code
    - We do this using the ! operator

 */

func thisMayReturnNil(demoInput: String) -> String? {
    if demoInput == "hello" {
        return "hello there"
    } else if demoInput == "hi" {
        return "hi there"
    } else {
        return nil
    }
}

var hello = thisMayReturnNil(demoInput: "hello")
var optionalDemo = thisMayReturnNil(demoInput: "can I please get back nil")

// this is fine because we know that hello does contain a String (as we passed in the correct input) - although in theory it should be properly unwrapped as thisMayReturnNil() has a return type of String? i.e. an optional
print(hello)

// if we just print optionalDemo, it's fine, because we can print 'nil'
print(optionalDemo)

// but now let's try to actually perform some actions on optionalDemo which do require them to be Strings - this is where problems start

hello?.count
// this line below will just not compile because optionalDemo needs to be unwrapped
//optionalDemo.count

// this line will cause the following error: "Unexpectedly found nil while unwrapping an Optional value". This is because the value (sort of) does get unwrapped but we don't get the value that we need / that we were expecting.
// optionalDemo!.count

// The way to deal with optionals properly is as follows - 'if let' checks whether we got back a nil or an actual value. We only enter the 'if' portion of the code if we don't get back nil

if let optionalDemo = thisMayReturnNil(demoInput: "can I please get back nil") {
    print("successfully unwrapped optionalDemo")
} else {
    print("Couldn't unwrap optionalDemo")
}

// similarly for 'hello'
if let hello = thisMayReturnNil(demoInput: "hello") {
    print(hello)
} else {
    print("Couldn't unwrap hello")
}

// worth noting that accessing values in a dict based on a value key return optionals

var demoDict = ["one": 1, "two": 2, "three": 3]
print(demoDict["one"]) //-> note the error on the right about expressed coercion; we should really be unwrapping this

// you can use the nil-coalescing operator to provide a default value in case the optional unwraps to nil; note that this line doesn't throw a warning, unlike line 62 above
var demoDict2 = demoDict["two"] ?? 2
print(demoDict2)

/* Optional chaining
 Optional chaining allows you to run some code only on an optional, only if that optional returns a value. More formally, it is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil.
 */

// a function that may return a String but could also return nil
func returnF1Team(number: Int) -> String? {
    switch number {
    case 1:
        return "Mercedes"
    case 2:
        return "Red Bull"
    default:
        return nil
    }
}
// myTeam is an optional because returnF1Team could return a nil
var myTeam = returnF1Team(number: 9)
// the commented out line below will crash the program. myTeam! will unwrap to be nil, and .uppercased() only knows how to work on Strings so this will throw a runtime error.
//print("My team is \(myTeam!.uppercased())")

// so instead, we tell the program - 'uppercase the value of myTeam, but only if myTeam actually has an underlying value rather than nil. The ? is actually similar to ! (i.e. forced unwrapping) except that it fails gracefully instead of crashing the program.
print("My team is \(myTeam?.uppercased())")

// we could also do this:
if let myTeam1 = myTeam?.uppercased() {
    print("My team #1 is \(myTeam1)")
} else {
    print("Hmmm, I don't know that team")
}

/* Guard let vs if let
 
 'if let' keeps the unwrapped value in the current condition / loop / function. 'guard let' is designed to exit the current condition / loop / function, and any values unwerapped using it will stay around after the check. Note that 'guard let' requires that you exit the current scope (i.e. we must return if the 'guard let' fails).
 
 A few points to note on usage / style (largely from [this discussion on SO](https://stackoverflow.com/questions/32256834/swift-guard-let-vs-if-let)):
 * if the 'if-let' block was going to be the rest of the function (or if you otherwise going to perform significant computations in the 'if-let' brach), it's best to use 'guard let';
 * generally, use 'guard', when you have a much higher expectancy that you will get back a value rather than nil (e.g. whre you're expecting a file to be there and something's gone wrong and it isn't);
 * avoid 'guard let' if it's 'else' clause introduces side effects;
 * it's not possible to use 'guard let' outside a function.
 
 */

func returnMeaningOfLife() -> String? {
    return ("happiness")
}

if let meaningOfLife = returnMeaningOfLife() {
    // this line will print fine
    print(meaningOfLife)
}
// the commented-out line below won't copile because meaningOfLife doesn't exist in this scope
//print(meaningOfLife)

// recall that 'guard let' needs to be used inside function
func printMeaningOfLife() -> () {
    guard let meaningOfLife = returnMeaningOfLife() else {
        return
    }
    print("meaningOfLife using guard let: \(meaningOfLife)")
}
printMeaningOfLife()











