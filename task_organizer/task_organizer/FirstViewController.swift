//
//  FirstViewController.swift
//  task_organizer
//
//  Created by Mindy Lou on 8/2/16.
//  Copyright © 2016 Mindy Lou. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblTasks: UITableView!
    let tableColor = UIColor(red: 108, green: 91, blue: 123, alpha: 1)

    // Reload table data upon each load of the view
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTasks.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tblTasks.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Pull data out of array to display number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskMgr.tasks.count
        
    }
    
    // Set cell name, description to task name, description, heading/subtitle look
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default Tasks")
        
        cell.backgroundColor = tableColor
        cell.textLabel!.text = taskMgr.tasks[indexPath.row].name
        cell.detailTextLabel!.text = taskMgr.tasks[indexPath.row].description
        
        
        return cell
    }
    
    // Show delete if swipe left, then reload list
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            taskMgr.tasks.removeAtIndex(indexPath.row)
            tblTasks.reloadData()
        }
    }


}

