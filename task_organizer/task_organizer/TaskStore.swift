//
//  TaskStore.swift
//  task_organizer
//
//  Created by Mindy Lou on 8/1/16.
//  Copyright © 2016 Mindy Lou. All rights reserved.
//

import Foundation

class TaskStore{
    
    // use a single task store
    class var sharedInstance: TaskStore{
        struct Static{
            static let instance=TaskStore()
        }
        
        return Static.instance
    }
    
    var tasks:[Task]=[]
    
    // add task
    func add(task:Task){
        tasks.append(task)
    }
    
    // replace task at given index with new task
    func replace(task:Task, atIndex index:Int){
        tasks[index] = task
    }
    
    // get task at index
    func getIndex(index:Int) -> Task{
        return tasks[index]
    }
    
    var count: Int {
        get{
            return tasks.count
        }
    }
    
    func removeTaskAtIndex(index: Int) {
        tasks.removeAtIndex(index)
    }
}