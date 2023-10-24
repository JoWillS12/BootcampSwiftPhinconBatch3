//: [Previous](@previous)

import Foundation

// Struct Example 1

struct Person {
    var name: String
    var age: Int
    var friend: [Friends]
}

struct Friends {
    var name: String
    var age: Int
}

var friendList = Friends(name: "Chris", age: 20)
var personOne = Person(name: "John", age: 17, friend: [friendList])

if let friend = personOne.friend.first {
    print("Person's name is \(personOne.name), he's \(personOne.age) years old and has a friend named \(friend.name) who is \(friend.age) years old.")
} else {
    print("Person's name is \(personOne.name), he's \(personOne.age) years old and has no friends.")
}


// Struct Example 2

struct TrafficLight {
    enum State {
        case red
        case yellow
        case green
    }
    
    var currentState: State
    
    func nextLight() -> TrafficLight {
        switch currentState {
        case .red:
            return TrafficLight(currentState: .green)
        case .yellow:
            return TrafficLight(currentState: .red)
        case .green:
            return TrafficLight(currentState: .yellow)
        }
    }
}

var trafficLight = TrafficLight(currentState: .red)
print("Current state: \(trafficLight.currentState)")

trafficLight = trafficLight.nextLight()
print("Changed state: \(trafficLight.currentState)")


//: [Next](@next)
