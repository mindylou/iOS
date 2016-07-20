//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var message = "Hello world!"
print(message)

// declaring type is optional
var a:Int = 1
var b:Int = 15
var total:Int = a+b
print(total)

if(total < 20){
    print("Hello")
}

class Person{
    
    var name: String = "initial name"
    
    init(){
    }
    
    func sayCheese(){
        print("cheese")
    }
    
    func walk(){
        print("I'm walking")
    }
}

var firstPerson = Person()
firstPerson.name = "Alice"

var a_person = Person()
a_person.name = "Alice"
a_person.walk()

// Superhuman: a subclass of Person
class Superhuman:Person{
    
    var alter_ego_name:String = "Clark"
    
    override init() {
        super.init()
        super.name = "Super duper"
    }
    
    func fly(){
        print("I'm flying")
    }
    
    override func walk(){
        print("I'm walking really fast")
        super.walk()
    }
}

var b_person = Superhuman()
b_person.name
b_person.walk()
b_person.fly()

