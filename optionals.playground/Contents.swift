import Cocoa

/* Fundamentals
 
 Recap - from memory:
 * Optionals are types which may contain a value or nil.
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








