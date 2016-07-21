//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// arc4random: imported from UIKit, generates a random number between 0, #-1
var random_number = arc4random_uniform(13) + 1 // random number from 1-13

// adding Strings:
var some_text = "balloon"
String(format: "te%@st", some_text)

// adding Strings to ints:
String(format: "card%i", random_number)

// ARRAYS: all have to be same type
var my_array:[String] = ["book", "cat"]

// length of array
my_array.count

// inserting new elements into array
my_array.insert("dog", atIndex: 0)
my_array.append("dolphin")
my_array += ["elephant", "truck"]

my_array.removeAtIndex(1)

// creating a new array object
var int_array:[Int] = [Int]()
int_array.append(0)

// CONDITIONALS:
var a = 9

if a < 10{
    print("hello")
}
else if a < 13{
    print("woah")
}
else {
    print("cool")
}