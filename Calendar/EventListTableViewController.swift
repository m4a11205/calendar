//
//  EventListTableViewController.swift
//  Calendar
//
//  Created by Ted on 2015/10/24.
//  Copyright © 2015年 Ted Chuang. All rights reserved.
//

import UIKit
import CoreData

class EventListTableViewController: UITableViewController {
    
    var totalEntries: Int = 0

    @IBOutlet weak var tblLog: UITableView!
    
    @IBAction func btnClearAll(sender: AnyObject) {
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "UserEvents")
        request.returnsObjectsAsFaults = false
        let results: NSArray = try! context.executeFetchRequest(request)
        
        for eventEntry: AnyObject in results{
            context.deleteObject(eventEntry as! NSManagedObject)
        }
        do {
            try context.save()
        } catch _ {
        }
        totalEntries = 0
        tblLog?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: "UserEvents")
        request.returnsObjectsAsFaults = false
        
        totalEntries = context.countForFetchRequest(request, error: nil) as Int!

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalEntries
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "UserEvents")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.executeFetchRequest(request)) as NSArray!
        
        //get contents and put into cell
        let thisEvent: UserEvents = results[indexPath.row] as! UserEvents
        cell.textLabel?.text = thisEvent.title
        cell.detailTextLabel?.text = thisEvent.date
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        //delete object from entity, remove from list
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let context = appDel.managedObjectContext
        let request = NSFetchRequest(entityName: "UserEvents")
        request.returnsObjectsAsFaults = false
        
        let results: NSArray = (try? context.executeFetchRequest(request)) as NSArray!
        
        //Get evnet that is being deeleted
        let tmpObject: NSManagedObject = results[indexPath.row] as! NSManagedObject
        let delEvent = tmpObject.valueForKey("title") as? String
        
        context.deleteObject(results[indexPath.row] as! NSManagedObject)
        do {
            try context.save()
        } catch _ {
        }
        totalEntries = totalEntries - 1
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }

}
