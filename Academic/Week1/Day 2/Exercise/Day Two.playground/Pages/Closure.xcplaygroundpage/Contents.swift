//: [Previous](@previous)

import Foundation

// closure that accepts one parameter
let greetUser = { (name: String)  in
    print("Hey there, \(name).")
}
greetUser("John")

// closure definition
var findValue = { (x: Int) -> (Int) in
  var value = x * x
  return value
}

// closure call
var result = findValue(14)

print("Square:",result)

// define a function and pass closure
func grabLunch(search: ()->()) {
  print("LUNCH TIME")

  // closure call
  search()
}

// pass closure as a parameter
grabLunch(search: {
   print("2 miles away")
})

// use of trailing closure
func grabLunch(message: String, search: ()->()) {
   print(message)
   search()
}

grabLunch(message:"LUNCH TIME")  {
  print("2 miles away")
}

// define a function with automatic closure
func display(greet: @autoclosure ()->()) {
 greet()
}
// pass closure without {}
display(greet: print("Hello !"))
//: [Next](@next)
