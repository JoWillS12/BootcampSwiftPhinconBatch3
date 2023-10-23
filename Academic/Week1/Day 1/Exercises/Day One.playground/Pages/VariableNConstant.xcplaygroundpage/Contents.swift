//: [Previous](@previous)

import Foundation

// Using `var` to declare a mutable variable
var myVariable = 10
myVariable = 20 // You can change the value of a variable declared with `var`
print("Value of myVariable (var) is \(myVariable)")

// Using `let` to declare an immutable constant
let myConstant = 30
// Attempting to change a constant will result in a compilation error
// myConstant = 40 // Uncommenting this line will result in a compilation error
print("Value of myConstant (let) is \(myConstant)")

// Variables can be of different types
var name: String = "John"
var age: Int = 25
var isStudent: Bool = true

// Constants can also be of different types
let pi: Double = 3.141592
let greeting: String = "Hello, World!"
let isRaining: Bool = false

// You can use type inference to simplify variable/constant declarations
var favoriteColor = "Blue" // Swift infers the type as String
let daysInAWeek = 7 // Swift infers the type as Int

// Variable and constant names should be descriptive
var temperatureInCelsius: Double = 25.5
let maxAllowedAttempts: Int = 3

// Variables and constants can be used in expressions
let radius: Double = 5.0
let area = Double.pi * pow(radius, 2) // Calculate the area of a circle

// Printing the calculated area
print("The area of a circle with a radius of \(radius) is \(area)")
