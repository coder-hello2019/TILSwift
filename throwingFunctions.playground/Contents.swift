import Cocoa

/* Fundamentals
 
Throwing functions and do-catch functionality are used to handle situations in which a function may throw an error. The example here is self-contained but this is particularly useful, for example, when making network calls.
 
 The key logic here works as follows:
    * whenever we think that a function may return an error, we have to first 'try' and get the actual result from it, using a 'try' statement;
    * try statements are enclosed in the 'do' portion of do-catch statements - we try to get the result inside the 'do', and catch any errors inside the 'catch';
    * in order to be able to 'catch' an error, we need to use a throwing function i.e. a function capable of throwing an error. These functions are marked with a 'throws' keyword before their return arrow (i.e. after their parameters). This keyword tells us that a function may throw an error (but it doesn't necessarily have to). Catch statements can be made to match specific patterns, so that they only catch the specified types of errors instead of all errors.
 
 */

// a dummy error that does nothing - it's just for example purposes
enum DummyError: Error {
    case demoError
}

// MARK: demo throwing functions

// a dummy throwing function - it returns a string if 'true' is passed into it and throws an error otherwise
func thisFunctionThrows (isTrue: Bool) throws -> String {
    if isTrue == true {
        return "This should print :)"
    } else {
        throw DummyError.demoError
    }
}

// a dummy throwing function that ALWAYS throws an error
func thisFuncAlwaysThrows () throws -> Void {
    throw DummyError.demoError
}

// MARK: demo do-catch statements

// this is how we would use a throwing function in practice - in the most basic way possible
do {
    var testVar = try thisFunctionThrows(isTrue: true)
    print("Success, we've received the following string back from the function: \(testVar)")
} catch {
    print("The function returned an error")
}

// we can make this a bit more helpful by giving the error a var name in the catch statement and printing some info about it
do {
    let testVar = try thisFunctionThrows(isTrue: false)
} catch let errorText {
    print("There was an error: \(errorText)")
}

// One useful point to note is that you can have as many 'try' statements in a 'do' as you want. HOWEVER, if any one of them does throw an error, you're immediately dropped into the 'catch' (even if a later one of the 'try's would have produced an actual result).
// A way to get around this is to make the first try inside the 'do' optional (i.e. try?). This way, firstTry will just have a nil value instead of throwing an error and, because an error is not thrown, we won't be pushed into the catch. See more on optional 'try's below.

do {
    let firstTry: Void = try thisFuncAlwaysThrows()
    let secondTry = try thisFunctionThrows(isTrue: true)
} catch {
    print("We get thrown here even though secondTry would have produced a String without any errors")
}

/* Optional try statements
 
 In some situations, we may not care about the error being thrown (but think about this carefully!). In that case, instead of throwing and catching the error, we can make the try statement optional ('try' becomes 'try?'). Instead of throwing the error, the 'try' interprets the errror as a nil value and proceeds.
 
 Optional 'try's can be force unwrapped but, as per usual, this is generally not a good thing to attempt.
 
 */

do {
    if let firstTry = try? thisFuncAlwaysThrows() {
        print("This should never be printed because the try always receives an error")
    }
    // secondTry will now print
    let secondTry = try thisFunctionThrows(isTrue: true)
    print(secondTry)
} catch {
    print("We don't get thrown here, unless something goes wrong with secondTry")
}

