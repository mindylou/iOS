//
//  SecondViewController.swift
//  task_organizer
//
//  Created by Mindy Lou on 8/2/16.
//  Copyright © 2016 Mindy Lou. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtTask: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //adding records of tasks
    @IBAction func btnAddTask(sender:UIButton){
        if (txtTask.text==""){
            // task title is blank, don't add a record
        }
        else {
            // add record
            taskMgr.addTask(txtTask.text!, desc: txtDesc.text!)
            
            // dismiss keyboard and reset fields
            self.view.endEditing(true)
            txtTask.text = nil
            txtDesc.text = nil
        }
    }
    
    // dismiss keyboard when user touches screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // dismiss keyboard when user presses return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


}

