//
//  AddEventViewController.swift
//  Calendar
//
//  Created by Ted on 2015/10/24.
//  Copyright © 2015年 Ted Chuang. All rights reserved.
//

import UIKit
import CoreData

class AddEventViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtInfo: UITextField!
    
    @IBOutlet weak var eventDatePicker: UIDatePicker!
    
    @IBAction func btnSavePressed(sender: UIButton) {
        if let title = txtTitle.text{
            if title.isEmpty == false{
                let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
                let context: NSManagedObjectContext = appDel.managedObjectContext
                let ent = NSEntityDescription.entityForName("UserEvents", inManagedObjectContext: context)!
                
                //Instance of our custom class, reference to entity
                var newEvent = UserEvents(entity: ent, insertIntoManagedObjectContext: context)
                
                //Fill in the Core Data
                newEvent.title = title
                newEvent.info = txtInfo.text!
                
                let dateFormatter = NSDateFormatter()
//                let curLocale: NSLocale = NSLocale.currentLocale()
//                let formatString: NSString = NSDateFormatter.dateFormatFromTemplate("EdMMM h:mm a", options: 0, locale: curLocale)!
//                dateFormatter.dateFormat = formatString as String
//                newEvent.date = dateFormatter.stringFromDate(NSDate())
                
                dateFormatter.dateFormat = "YYYY/MM/dd, EEE, h:mm a"
                newEvent.date = dateFormatter.stringFromDate(eventDatePicker.date)
                
                do {
                    try context.save()
                } catch _ {
                }
            }else{
                //User carelessly pressed save button without entering weight.
                var alert:UIAlertController = UIAlertController(title: "No Event Entered", message: "Enter your event before pressing save.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {(result)in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }else{
            print("No element text for the UITextField 'txtTitle'")
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
