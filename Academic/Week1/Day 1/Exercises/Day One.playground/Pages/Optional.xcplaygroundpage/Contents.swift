//: [Previous](@previous)

import Foundation

// Example 1: Declaring an Optional
// An optional is a type that can hold either a value or be nil (no value).

print("Example 1: Declaring an Optional")
var name: String? // Declaring an optional string 'name' that can be nil.
print("Name is \(name)") // 'name' is nil because it hasn't been assigned a value.

// Example 2: Assigning a Value to an Optional
print("\nExample 2: Assigning a Value to an Optional")
name = "John"
print("Name is \(name)") // 'name' now contains a value.

// Example 3: Unwrapping an Optional
// Unwrapping is necessary to access the value inside an optional.

print("\nExample 3: Unwrapping an Optional")
if let unwrappedName = name {
    print("Unwrapped name is \(unwrappedName)")
} else {
    print("Name is nil")
}
// Using optional binding to safely unwrap and access the value. 'unwrappedName' contains the value.

// Example 4: Force Unwrapping
// Force unwrapping can be used when you're certain the optional contains a value.

print("\nExample 4: Force Unwrapping")
let unwrappedName = name!
print("Force unwrapped name is \(unwrappedName)")
// This will crash if 'name' is nil, so use with caution.

// Example 5: Implicitly Unwrapped Optionals
// Implicitly unwrapped optionals assume the value is non-nil after initial assignment.

print("\nExample 5: Implicitly Unwrapped Optionals")
var greeting: String! = "Hello, World!"
print("Implicitly unwrapped greeting is \(greeting)")
// 'greeting' can be used without unwrapping after initial assignment.

