//
//  CustomizeController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit

class CustomizeController: UIViewController{

    
    @IBOutlet weak var dailyReminderSwitch: UISwitch!
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
            data.deleteEvent()
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
        //data.start = datePicker.date
        println(strDate)
    }

    @IBAction func switchClicked(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        
        if dailyReminderSwitch.on{
           
            addReminder()
            
        }else {
            println("deleting")
            data.deleteEvent()
        }
    }
    func addReminder(){
     var eventStore = EKEventStore()
    var reminder = EKReminder(eventStore: eventStore)
    let calendar = NSCalendar.currentCalendar()
    let nowDate = NSDate()
    let alarmDate = nowDate.dateByAddingTimeInterval(60)
    var alarmForReminder = EKAlarm(absoluteDate: alarmDate)
    var date = NSDateComponents()
    var components = calendar.components(.CalendarUnitDay, fromDateComponents: date, toDateComponents: date, options: nil)
    let month = components.month
    let day = components.day
    let year = components.year
    let recurCount = 365
    let recurStart = nowDate
    let recurEnd = EKRecurrenceEnd.recurrenceEndWithOccurrenceCount(recurCount) as EKRecurrenceEnd
    
    let recurrenceRule = EKRecurrenceRule(recurrenceWithFrequency: EKRecurrenceFrequencyDaily, interval: 1, end: recurEnd)
    
    reminder.addAlarm(alarmForReminder)
    reminder.calendar = eventStore.defaultCalendarForNewReminders()
    reminder.title = "Work Out"
    reminder.notes = "Check-In with FitWhen!!"
    
    //reminder.addRecurrenceRule(recurrenceRule)
    
    eventStore.saveReminder(reminder, commit: true, error: NSErrorPointer())
    }
    //receives unwind from workout timing view
    @IBAction func returnToHome(segue: UIStoryboardSegue) {
        println("return to home")
    }
    //seque to customize view controller
    @IBAction func returnHome(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        data.deleteEvent()
        
        performSegueWithIdentifier("customize", sender: self)
        
    }
    

}
