//
//  TaskManager.swift
//  task_organizer
//
//  Created by Mindy Lou on 8/2/16.
//  Copyright © 2016 Mindy Lou. All rights reserved.
//

import UIKit

var taskMgr:TaskManager = TaskManager()

struct task{
    var name = "Name"
    var description = "Description"
}

class TaskManager: NSObject {
    var tasks = [task]()
    
    func addTask(_ nom:String, desc:String){
        tasks.append(task(name: nom, description: desc))
    }
}
