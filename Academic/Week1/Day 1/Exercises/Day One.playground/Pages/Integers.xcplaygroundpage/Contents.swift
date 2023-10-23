//: [Previous](@previous)

import Foundation


// Example 1: Integer Variables
var age: Int = 25
// Declaring an integer variable 'age' and initializing it with the value 25.

// Example 2: Integer Constants
let numberOfApples: Int = 10
// Declaring an integer constant 'numberOfApples' and setting its value to 10.

// Example 3: Arithmetic Operations
let sum = age + numberOfApples
// Adding the 'age' variable and 'numberOfApples' constant to calculate the sum.

let difference = age - numberOfApples
// Subtracting 'numberOfApples' from 'age' to calculate the difference.

let product = age * numberOfApples
// Multiplying 'age' and 'numberOfApples' to calculate the product.

let quotient = age / 5
// Dividing 'age' by 5 to calculate the quotient.

let remainder = age % 7
// Calculating the remainder when 'age' is divided by 7.

// Example 4: Overflow Handling
var largeNumber: Int = Int.max
// Setting 'largeNumber' to the maximum representable integer value.

// Uncomment the next line to see overflow error
// largeNumber = largeNumber + 1

// Example 5: Type Conversion
let pi = 3.14159
let integerPi = Int(pi)
// Converting the 'pi' floating-point number to an integer.

// Example 6: Integer Ranges
let rangeOfNumbers = 1...5
// Creating a closed range from 1 to 5 (inclusive).

for number in rangeOfNumbers {
    print(number)
}
// Printing the numbers within the range.

// Example 7: Checking for Even or Odd
let someNumber = 7

if someNumber % 2 == 0 {
    print("The number is even.")
} else {
    print("The number is odd.")
}
// Checking if 'someNumber' is even or odd using the remainder operator.

// Example 8: Absolute Value
let negativeNumber = -10
let absoluteValue = abs(negativeNumber)
// Finding the absolute value of 'negativeNumber'.

// Printing the results
print("Sum: \(sum)")
print("Difference: \(difference)")
print("Product: \(product)")
print("Quotient: \(quotient)")
print("Remainder: \(remainder)")
print("Large Number: \(largeNumber)")
print("Integer Pi: \(integerPi)")
print("Numbers in Range: \(Array(rangeOfNumbers))")
print("Absolute Value: \(absoluteValue)")

//: [Next](@next)
