//: [Previous](@previous)

import Foundation


// Example : Creating a simple enum
enum Direction {
    case north
    case south
    case east
    case west
}

// Using the enum
let playerDirection = Direction.north

switch playerDirection {
case .north:
    print("The player is moving north.")
case .south:
    print("The player is moving south.")
case .east:
    print("The player is moving east.")
case .west:
    print("The player is moving west.")
}

//: [Next](@next)
