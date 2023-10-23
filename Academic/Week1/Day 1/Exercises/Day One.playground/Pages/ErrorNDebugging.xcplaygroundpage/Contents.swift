//: [Previous](@previous)

import Foundation

// Example 1: Using try and catch for error handling
enum CustomError: Error {
    case notFound
    case invalidInput
}

func performOperation() throws {
    let randomNumber = Int.random(in: 1...10)
    
    if randomNumber < 5 {
        throw CustomError.notFound
    } else if randomNumber > 9 {
        throw CustomError.invalidInput
    }
    
    print("Operation was successful!")
}

do {
    try performOperation()
    print("No errors occurred.")
} catch CustomError.notFound {
    print("Error: Item not found.")
} catch CustomError.invalidInput {
    print("Error: Invalid input.")
} catch {
    print("An unexpected error occurred.")
}

// Example 2: Using assert for debugging
let age = 15

assert(age >= 18, "Age must be 18 or older for this operation.")
print("Operation can continue since the age is valid.")

// Example 3: Using precondition for safety checks
func divideNumbers(_ a: Int, by b: Int) {
    precondition(b != 0, "Division by zero is not allowed.")
    
    let result = a / b
    print("Result of the division: \(result)")
}

divideNumbers(10, by: 2)
divideNumbers(8, by: 0) // This line will trigger a precondition failure.
