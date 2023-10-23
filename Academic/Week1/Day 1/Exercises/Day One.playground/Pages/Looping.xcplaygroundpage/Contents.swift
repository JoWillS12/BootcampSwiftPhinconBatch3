//: [Previous](@previous)

import Foundation

// Example 1: for-in loop
// A for-in loop is used for iterating through a range or collection.

print("Example 1: for-in loop")
for i in 1...5 {
    print("Current number is \(i)")
}
// This loop iterates from 1 to 5 (inclusive) and prints the current number.

// Example 2: iterating over an array
// You can use a for-in loop to iterate over the elements in an array.

print("\nExample 2: Iterating over an array")
let fruits = ["Apple", "Banana", "Cherry", "Date"]
for fruit in fruits {
    print("I like \(fruit)")
}
// This loop iterates through the 'fruits' array and prints a message for each fruit.

