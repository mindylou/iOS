//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Person{
    
    var name:String
    var age:Int
    
    init(){
        self.name = "initial name"
        self.age = 10
    }
    
    func updateNameAndAge(name:String, age:Int){
        self.name = name
        self.age = age
    }
    
    // returns an Int
    func increaseAge(increase_by: Int) -> Int{
        self.age += increase_by
        
        return self.age
    }
    
    // type method, or class method
    class func averageAge() -> Int{
        return 50
    }
}

var a = Person()

// first parameter doesn't need parameter variable label
a.updateNameAndAge("Brad", age: 15)
a.name
a.age

var new_age = a.increaseAge(5)

// calling class method
var c = Person.averageAge()