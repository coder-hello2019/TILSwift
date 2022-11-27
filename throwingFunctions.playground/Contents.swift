import Cocoa

/* Fundamentals
 
Throwing functions and do-catch functionality are basic used to handle situations in which a function may return an actual result to us but it may also end up throwing an error. The example here is self-contained but this is particularly useful when e.g. making network calls as these are often out of our control as developers.
 
 The key logic here works as follows:
    * whenever we think that a function may return an error, we have to 'try' and get the result, using a try statement;
    * try statements are enclosed in the 'do' portion of do-catch statements - we try to get the result inside the 'do', and catch any errors inside the 'catch';
    * in order to be able to 'catch' an error, we need to use a throwing function i.e. a function capable of throwing an error. These functions are marked with a 'throws' keyword before their return type. This keyword tells us that a function may throw an error (but it doesn't necessarily have to).
 
 Resources:
    *
 
 */

// a dummy error that does nothing - it's just for example purposes
enum DummyError: Error {
    case testError
}

// a dummy throwing function - it returns a string if 'true' is passed into it and throws an error otherwise
func thisFunctionThrows (isTrue: Bool) throws -> String {
    if isTrue == true {
        return "True :)"
    } else {
        throw DummyError.testError
    }
}

// this is how we would use the throwing function in practice - in the most basic way possible
do {
    var testVar = try thisFunctionThrows(isTrue: true)
    print("Success, we've received the following string back from the function: \(testVar)")
} catch {
    print("The function returned an error")
}

// we can make this a bit more advanced by giving the error a var name in the catch statement and printing some more info about the error

do {
    let testVar = try thisFunctionThrows(isTrue: false)
} catch let errorText {
    print("There was an error: \(errorText)")
}
