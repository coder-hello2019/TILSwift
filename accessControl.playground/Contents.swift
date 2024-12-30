import UIKit

var greeting = "Hello, playground"

/*
 Sometimes we might want to impose certain restrictions in our code e.g. on when methods are used or
 what order they're used in. Access control is really about limiting what you and other developers can do - you stop yourself from amking mistakes!
 
This probably isn't as much of an issue for lone wolf indie devs, but definitely looks important
 when working as part of a bigger team to make sure that code is used as expected.
 
 Levels of protection:
 - private: don't let anything outside the struct use this
 - fileprivate: don't let anything outsidet the current file use this
 - public: let anyone, anywhere use this.
 - private(set) - let anyone read the property, but only let my internal methods write this (although this level is apparently not used all that much in protection, just in teaching/learning).
 
 Let's work through an example.

 */

struct BankAccount {
    var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if amount <= funds {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var myAccount = BankAccount()
myAccount.deposit(amount: 100)

// when we use the .withdraw() function below, we get back 'false' because there are insufficient funds in the account
myAccount.withdraw(amount: 1000)
print("Funds: \(myAccount.funds)")

// however - because the funds property of BankAccount is openly accessible to all the code here - we can just amend it freely irrespective of the constraints on withdrawals implemented in the withdraw function!
// this action would be invalid if var funds had been marked with the 'private' keyword. The code trying to amend that property outside the withdraw function would not complile. See PrivateAccount example below.
myAccount.funds -= 1000
print("Funds: \(myAccount.funds)")

// Let's try again with some restrictions on variable access

struct PrivateAccount {
    private(set) var funds = 0
    
    mutating func deposit(amount: Int) {
        funds += amount
        print("Funds after deposit: \(self.funds)")
    }
    
    mutating func withdraw(amount: Int) -> Bool {
        if amount <= funds {
            funds -= amount
            print("Funds after withdrawal: \(self.funds)")

            return true
        } else {
            print("Insufficient funds")
            return false
        }
    }
}

var privateAccount = PrivateAccount()
privateAccount.deposit(amount: 1000)
privateAccount.withdraw(amount: 500)
// note that - because we used private(set) rather than just strictly private - we can read the funds property but can't write to it
print("private(set) funds after deposit and withdrawal: \(privateAccount.funds)")

