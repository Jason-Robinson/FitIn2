//
//  CustomizeController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class CustomizeController: UIViewController{

    
    var homes = ["Workout Selection"]
    
    
    
    @IBOutlet weak var dailyPicker: UIDatePicker!
    var cell:UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

         dailyPicker.addTarget(self, action: Selector("dailyPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func showAlert(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        let optionMenu = UIAlertController(title: nil,  message: nil,preferredStyle: .ActionSheet)
        
        // 2
        
        let saveAction = UIAlertAction(title: "Restore Defaults", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            data.dailyReminderTime = "8:00 AM"
            data.workoutTimingStart = "9:00 AM"
            data.workoutTimingEnd = "5:00 PM"
            data.minWorkoutTime = 0
            println("Defaults restored")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("cancel alertscreen")
            
        })
        
        
        // 4
        
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    func dailyPickerChanged(datePicker:UIDatePicker) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        var dateFormatter = NSDateFormatter()
        
        //datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        data.dailyReminderTime = strDate
        
        println(strDate)
    }

    
    @IBAction func returnToHome(segue: UIStoryboardSegue) {
        println("return to home")
    }
    @IBAction func returnHome(sender: AnyObject) {
        performSegueWithIdentifier("customize", sender: self)
    }
    

}
