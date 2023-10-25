import UIKit

// Class Example 1
class Man {
    // Properties (instance variables) of the class
    var name: String
    var age: Int
    
    // Initializer (constructor) to set initial values for properties
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    // Method to greet the person
    func greet() {
        print("Hello, my name is \(name) and I am \(age) years old.")
    }
    
    
}

let person1 = Man(name: "John", age: 30)

person1.name = "Jane"
person1.age = 35

person1.greet()

// Class Example 2 : Protocol Extension
//Added protocol for class
protocol Fuel{
    func checkFuel()
}
//Using Inheritance Protocol
protocol Brake: Fuel{
    func brake()
}

//Superclass
class Dealer{
    func motoType(){
        print("Bike Type")
    }
}

class SuperBike: Dealer, Brake{
    
    var speed: Int
    
    //Initializer to set value for speed property
    override init() {
        speed = 180
    }
    
    //Overriding method from superclass
    override func motoType(){
        print("Yamaha XSR-900")
    }
    
    
}
//New method extension for SuperBike Class
extension SuperBike{
    //Added method from protocols
    func brake() {
        print("Brake")
    }
    func checkFuel() {
        print("Checking Fuel...")
        print("Fuel is Full")
    }
    func stop(){
        print("Engine Stopped")
    }
    func calculator(t: Int, y: Int, message: ()->())-> (Int, Int, Int){
        let q = t * y
        let w = t / y
        let e = t + y
        message()
        return (q , w, e)
    }
    
}



let a = SuperBike()

print(a.calculator(t: 2, y: 1){
    print("Hello")
})
a.speed = 250
a.motoType()
print("Superbike at \(a.speed) km/h")
a.brake()
a.stop()
a.checkFuel()

// Class Example 3
// Protocol: PersonProtocol
protocol PersonProtocol {
    var name: String { get set }
    func sayHello()
}

// Class: Person
class Person: PersonProtocol {
    var name: String
    
    // Initializer
    init(name: String) {
        self.name = name
    }
    
    // Conform to the protocol
    func sayHello() {
        print("Hello, my name is \(name)")
    }
    
    func num(number: Int) -> Int{
        let add = number + number
        return add
    }
}

// Extension for Person class
extension Person {
    func introduce() {
        print("I'm a person named \(name).")
    }
}

// Class: Student (Inherits from Person)
class Student: Person {
    var studentID: String
    
    // Initializer
    init(name: String, studentID: String) {
        self.studentID = studentID
        super.init(name: name)
    }
    
    // Override the sayHello method
    override func sayHello() {
        print("Hello, I'm a student. My name is \(name) and my student ID is \(studentID)")
    }
    
}

let person = Person(name: "John")

print("Person's name: \(person.name)")

person.sayHello()
person.introduce()
let result = person.num(number: 3)
print(result)

let student = Student(name: "Ali", studentID: "S12345")

print("Student's name: \(student.name)")
print("Student's ID: \(student.studentID)")

student.sayHello()
student.introduce()


