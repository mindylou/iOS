//
//  Task.swift
//  task_organizer
//
//  Created by Mindy Lou on 8/1/16.
//  Copyright © 2016 Mindy Lou. All rights reserved.
//

import Foundation

struct Task {
    let title: String
    let notes: String
    
    init(title: String, notes: String) {
        self.title = title
        self.notes = notes
    }
}
