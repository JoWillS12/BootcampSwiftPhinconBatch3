import UIKit

// Example 1: Basic if statement
let isRaining = true

if isRaining {
    print("Bring an umbrella.") // If it's raining, print this message.
} else {
    print("Enjoy the sunshine.") // If it's not raining, print this message.
}

// Example 2: if-else if-else statement
let temperature = 28

if temperature < 10 {
    print("It's very cold.") // If temperature is less than 10, print this message.
} else if temperature >= 10 && temperature < 20 {
    print("It's cool.") // If temperature is between 10 and 19, print this message.
} else {
    print("It's warm.") // If none of the above conditions are met, print this message.
}

// Example 3: Switch statement
let dayOfWeek = "Monday"

switch dayOfWeek {
case "Monday":
    print("It's the start of the workweek.")
case "Friday":
    print("It's almost the weekend!")
default:
    print("It's a regular day.") // If the day doesn't match any case, print this message.
}

// Example 4: Using the ternary conditional operator (a ? b : c)
let age = 18
let canVote = age >= 18 ? "Yes, you can vote." : "No, you cannot vote."

print(canVote) // Print the result of the ternary operator.

// Example 5: Nested if statements
let isSunny = true
let isWindy = false

if isSunny {
    if isWindy {
        print("It's sunny and windy. Go fly a kite!")
    } else {
        print("It's sunny but not windy. Enjoy the sunshine.")
    }
} else {
    print("It's not sunny. Bring an umbrella or stay indoors.")
}
