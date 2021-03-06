//
//  WorkoutTiming.swift
//  Fit In
//
//  Created by Jason Robinson on 12/4/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class WorkoutTimingViewController: UIViewController {
   
    
    
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var endPicker: UIDatePicker!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var sliderValue: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        
        sliderLabel.text = "\(data.minWorkoutTime)"
        
        startPicker.addTarget(self, action: Selector("startPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        endPicker.addTarget(self, action: Selector("endPickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        var endValue:String!
        var startValue:String!
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        println(defaults.integerForKey("sliderValue"))
        var value = defaults.integerForKey("sliderValue")
        
        if let firstNameIsNotNill = defaults.objectForKey("startStrValue") as? String{
            startValue = defaults.objectForKey("startStrValue") as String!}
        else{
            startValue = "9:00 AM"
        }

        
        if let firstNameIsNotNill = defaults.objectForKey("endStrValue") as? String{
            endValue = defaults.objectForKey("endStrValue") as String!}
        else{
            endValue = "5:00 PM"
        }
        startTime.text = "\(startValue)"
        endTime.text = "\(endValue)"
        sliderLabel.text = "\(value)"
        sliderValue.value = Float(value)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        println("viewWillAppear in Docs")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear in Docs")
                
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonPress(sender: AnyObject) {
        println("Button pressed...will dissmiss")
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        println(defaults.integerForKey("sliderValue"))
        performSegueWithIdentifier("Timing", sender: self)
        
        //last action of view controller
    }
    func startPickerChanged(datePicker:UIDatePicker) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        var dateFormatter = NSDateFormatter()
        
        //datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        var startDefaultValue:String!
        startTime.text = startDefaultValue

        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(strDate, forKey: "startStrValue")
        //gets data from user defaults
        if let firstNameIsNotNill = defaults.objectForKey("startStrValue") as? String {
            
            startDefaultValue = defaults.objectForKey("startStrValue") as String
        }
        
        startTime.text = startDefaultValue
    }
    func endPickerChanged(datePicker:UIDatePicker) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        var dateFormatter = NSDateFormatter()
        
        //datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        var endDefaultValue:String!
        endTime.text = endDefaultValue
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(strDate, forKey: "endStrValue")
        //gets data from user defaults
        if let firstNameIsNotNill = defaults.objectForKey("endStrValue") as? String {
            
            endDefaultValue = defaults.objectForKey("endStrValue") as String
        }
        
        endTime.text = endDefaultValue
        
    }
    @IBAction func sliderChange(sender: UISlider) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        var currentValue = Int(sender.value)
        var valueFromUserDefaults:Int!
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(currentValue, forKey: "sliderValue")
        defaults.synchronize()
        //gets data from user defaults
        if (defaults.integerForKey("sliderValue") >= 0){
            println("test")
            valueFromUserDefaults = defaults.integerForKey("sliderValue")
        }

        
        
        sliderLabel.text = "\(valueFromUserDefaults)"
    }
}
