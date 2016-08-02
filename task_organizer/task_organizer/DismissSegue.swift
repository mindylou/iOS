//
//  DismissSegue.swift
//  task_organizer
//
//  Created by Mindy Lou on 8/1/16.
//  Copyright © 2016 Mindy Lou. All rights reserved.
//

import UIKit

@objc(DismissSegue) class DismissSegue: UIStoryboardSegue {
    override func perform() {
        if let controller = sourceViewController.presentingViewController {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
