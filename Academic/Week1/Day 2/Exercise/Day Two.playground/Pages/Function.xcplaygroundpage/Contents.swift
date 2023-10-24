//: [Previous](@previous)

import Foundation

// Example 1: Basic Function
// Functions are blocks of code that can be reused by calling them.

func greet(name: String) {
    print("Hello, \(name)!")
}

greet(name: "Alice")

// Example 2: Function with Return Value
// Functions can also return values.

func square(_ number: Int) -> Int {
    return number * number
}

let result = square(5)
print("Square of 5 is \(result)")

// Example 3: Function with Multiple Parameters
// Functions can have multiple parameters.

func calculateSum(of a: Int, and b: Int) -> Int {
    return a + b
}

let sum = calculateSum(of: 3, and: 4)
print("The sum of 3 and 4 is \(sum)")


// Example 4: Function with In-Out Parameters
// In-out parameters allow a function to modify the value of an external variable.

func swapValues(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}

var x = 5, y = 10
swapValues(&x, &y)
print("After swapping: x = \(x), y = \(y)")

// Example 5: Nested Functions
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

// Example 6: Function with a Closure
// Functions can accept closures (anonymous functions) as arguments.

func processNumbers(_ numbers: [Int], using closure: (Int) -> Int) {
    let result = numbers.map(closure)
    print("Processed numbers: \(result)")
}

let numbers = [1, 2, 3, 4, 5]
processNumbers(numbers) { number in
    return number * 2
}

// Example 7: Function with Enum and rawValue
enum Hari: String {
    case Senin, Selasa, Rabu, Kamis, Jumat
    case Sabtu, Minggu
}

func detectHolidays(hari: String) -> String {
    if let day = Hari(rawValue: hari) {
        switch day {
        case .Senin, .Selasa, .Rabu, .Kamis, .Jumat:
            return "Weekday."
        case .Sabtu, .Minggu:
            return "Holiday."
        }
    } else {
        return "Invalid day."
    }
}

let dayResult = detectHolidays(hari: "Senin")
print(dayResult) // Output: Weekday.



//: [Next](@next)
