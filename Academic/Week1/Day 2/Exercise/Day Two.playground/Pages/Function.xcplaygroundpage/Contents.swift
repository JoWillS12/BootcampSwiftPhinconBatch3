//: [Previous](@previous)

import Foundation

// Example 1: Basic Function
// Functions are blocks of code that can be reused by calling them.

func greet(name: String) {
    print("Hello, \(name)!")
}

greet(name: "Alice")
greet(name: "Bob")
// The 'greet' function takes a 'name' parameter and prints a greeting with the provided name.

// Example 2: Function with Return Value
// Functions can also return values.

func square(_ number: Int) -> Int {
    return number * number
}

let result = square(5)
print("Square of 5 is \(result)")
// The 'square' function takes an integer 'number' and returns its square.

// Example 3: Function with Multiple Parameters
// Functions can have multiple parameters.

func calculateSum(of a: Int, and b: Int) -> Int {
    return a + b
}

let sum = calculateSum(of: 3, and: 4)
print("The sum of 3 and 4 is \(sum)")
// The 'calculateSum' function takes two integers and returns their sum.

// Example 4: Function with Default Parameter Value
// Default parameter values can be provided for function parameters.

func power(_ base: Int, to exponent: Int = 2) -> Int {
    return Int(pow(Double(base), Double(exponent)))
}

let squareResult = power(4)
let cubeResult = power(3, to: 3)
print("4 squared is \(squareResult), 3 cubed is \(cubeResult)")
// The 'power' function calculates the power of a number with an optional exponent (defaulting to 2).

// Example 5: Function with Variadic Parameters
// Variadic parameters allow a variable number of arguments.

func average(_ numbers: Double...) -> Double {
    let sum = numbers.reduce(0, +)
    return sum / Double(numbers.count)
}

let avg1 = average(1, 2, 3, 4, 5)
let avg2 = average(10, 20, 30)
print("Average 1: \(avg1), Average 2: \(avg2)")
// The 'average' function calculates the average of a variable number of double values.

// Example 6: Function with In-Out Parameters
// In-out parameters allow a function to modify the value of an external variable.

func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var x = 5, y = 10
swapValues(&x, &y)
print("After swapping: x = \(x), y = \(y)")
// The 'swapValues' function swaps the values of two integers using in-out parameters.

// Example 7: Function as a Parameter
// Functions can be passed as parameters to other functions.

func applyOperation(_ a: Int, _ b: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(a, b)
}

let additionResult = applyOperation(3, 4, operation: { (a, b) in a + b })
let multiplicationResult = applyOperation(2, 5, operation: { (a, b) in a * b })
print("Addition Result: \(additionResult), Multiplication Result: \(multiplicationResult)")
// The 'applyOperation' function takes two integers and a function as a parameter to perform the operation.

// Example 8: Nested Functions
// Functions can be defined within other functions.

func performOperation(_ operation: String) -> (Int, Int) -> Int {
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    func multiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    
    if operation == "add" {
        return add
    } else {
        return multiply
    }
}

let additionFunction = performOperation("add")
let multiplicationFunction = performOperation("multiply")
let result1 = additionFunction(3, 4)
let result2 = multiplicationFunction(3, 4)
print("Result 1: \(result1), Result 2: \(result2)")
// The 'performOperation' function returns a nested function based on the operation type.

// Example 9: Function with a Closure
// Functions can accept closures (anonymous functions) as arguments.

func processNumbers(_ numbers: [Int], using closure: (Int) -> Int) {
    let result = numbers.map(closure)
    print("Processed numbers: \(result)")
}

let numbers = [1, 2, 3, 4, 5]
processNumbers(numbers) { number in
    return number * 2
}
// The 'processNumbers' function applies the closure to each number in the array and prints the results.


// Example 10: Function with Enum
enum Hari: String{
    case Senin, Selasa, Rabu, Kamis, Jumat
    case Sabtu, Minggu
}

func detectHolidays(hari: Hari)-> String{
    switch hari {
    case .Senin, .Selasa, .Rabu, .Kamis, .Jumat:
        return("WeekDay.")
    case .Sabtu, .Minggu:
        return("Holoday.")
    }
}

detectHolidays(hari: .Senin)


//: [Next](@next)
