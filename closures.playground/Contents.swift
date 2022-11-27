import Cocoa

/* Fundamentals
 
 Closures are essentially stores of functionality - they contain some work that we want done, but not necessarily here and/or now. So closures allow us to pass that functionality around our code. Similar concept to lambdas. A lot of the time we could use functions to achieve the same thing as closures, but closures are more 'lightweight' in terms of style.
 
 Their syntax generally takes the following form (the 'in' keyword marks the start of the substantive work to be done):
 
 { (parameters) -> (return type) in
    some work gets done here
 }
 
 The examples below uses the .sorted method - which takes in another method as its parameter, specifying the order of sorting - to illustrate how closures syntax works.
 
 Resources:
 
    * See here for discussion of closures capturing values, closures as reference types and escaping closures: https://docs.swift.org/swift-book/LanguageGuide/Closures.html
    * See here for a useful cheat-sheet on closure declarations: http://goshdarnclosuresyntax.com/
 
 */

var faang = ["Twitter", "Meta", "Google", "Amazon"]


// in the first instance, we can just pass a function to .sorted - here is the long-form function
func inAlphaOrder(_ s1: String, _ s2: String) -> Bool {
    if s1 < s2 {
        return true
    } else {
        return false
    }
}

var sortedFaang = faang.sorted(by: inAlphaOrder)
print(sortedFaang)

// but actually, we could incorporate/pass the contents of the function directly into .sorted, like so (note how this matches the syntax structure described in the note above):
var sortedFaangWithClosure = faang.sorted(by: {(s1: String, s2: String) -> Bool in
    if s1 < s2 {
        return true
    } else {
        return false
    }
})

print(sortedFaangWithClosure) // produces the same result as sortedFaang above

// this can also be simplified further - firstly by just using the < operator, due to the short length of the comparison function, and by the removal of type annotations.
//Swift knows that s1 and s2 are Strings as .sorted is used on an array of Strings and it knows that a Bool needs to be returned here.

var simplifiedFaangWithClosure = faang.sorted(by: {(s1, s2) in return s1 < s2})
print(simplifiedFaangWithClosure)

// We can also (i) remove the 'return' keyword as Swift knows that a Bool needs to be returned, and (ii) refer to shorthand argument names like so:

var verySimplifiedFaangWithClosure = faang.sorted(by: {$0 < $1})
print(verySimplifiedFaangWithClosure)

/* Trailing closure syntax
 
 You use trailing closures to simplify the code when a  closuere is the last arguent to a function. There are a couple of ways to use a trailing closure:
 
 1. Set out the closure after the closing parentheses of a function i.e.
    functionName () {closure goes here}
 
 2. If the closure is the only argument being passed to the function, omit the function parentheses completely and set out the closure at the end i.e. functionName [no parentheses here] {closure goes here}
 
 See examples below. In each case, even though it technically sits outside the function, the closure remains an argumnt to the function.
 
 */

func functionTakingAClosure(closure: () -> Void) {
    print("This function takes in a closure")
    closure()
}

functionTakingAClosure(closure: {print("This example DOESN'T use a trailing closure, as the closure sits inside the function's parentheses and we use the argument name 'closure")})

functionTakingAClosure() {
    print("This example DOES have a trailing closure but still includes the function parentheses")
}

functionTakingAClosure {
    print("This is the body of the trailing closure which is just appended at the end of the function, with no parentheses")
}

// .map is a method that commmonly needs to have a closure passed in - the below code explores some more examples

var numbers = [1, 2, 3, 4, 5]

// this is a 'long-form' example of a trailing closure e.g. because we include the parameter types and use the function's parentheses
var doubledNumbers = numbers.map(){(num: Int) -> (Int) in
    return num * 2
}
print(doubledNumbers)

// this is a simplified version:
var tripledNumbers = numbers.map{$0 * 3}
print(tripledNumbers)
