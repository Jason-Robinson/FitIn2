//
//  WorkoutSelectionController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit



class WorkoutSelectionController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {

    var calCheck = "false"
    
    var eventStore = EKEventStore()
    //add workout button
    @IBOutlet weak var addWorkout: UIButton!
    
    //workout length picker variable
    @IBOutlet weak var pickerData: UIPickerView!
    
    var status:String = ""
    
    //time of day picker variable
    @IBOutlet weak var datePicker: UIDatePicker!
    
     //table cell variable
    var cell:UITableViewCell!
    var returnStatus = "none"
    
    
    var strTime:String = ""
    var strWorkout:String = ""
    
    //workout data arrays
    var homeW:[String] = []
    var gymW:[String] = []
    var officeW:[String] = []
    
    
    
    //ID for segment control
    var segmentIdentifier = 0;
    
    //segmented controller outlet
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //table view outlet
    @IBOutlet weak var tableView: UITableView!
    
    //workout length options in picker
    var picker = ["5","10","15","20","25","30","35","40","45","50","55","60"]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        //creates variable to AppDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()

        homeW = data.home
        gymW = data.gym
        officeW = data.office
        
        

        
        self.tableView.reloadData()
        
        //targets date picker changed function
       datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    //returns number of rows based on the count of the works arrays
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var result = 0
        
        //home
        if (segmentIdentifier == 0){
            result = homeW.count
        }
            //office
        else if (segmentIdentifier == 1){
            result = officeW.count
        }
            //gym
        else if (segmentIdentifier == 2){
            result = gymW.count
        }
        
        return result
    }
    
    //gets current index and adds the matching element from the struct to the table view, does this to all elements
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //ientifies which cell to use, must set Reuse ID in story board to match "Cell" <-generic name for cell
        cell = tableView.dequeueReusableCellWithIdentifier("workoutCells", forIndexPath: indexPath) as UITableViewCell
        
        //strut objects on specific row
        let gymData = gymW[indexPath.row]
        let homeData = homeW[indexPath.row]
        let officeData = officeW[indexPath.row]
        
        //adds struct data to tableView
        if (segmentIdentifier == 0){
            cell.textLabel?.text = homeData//home
           
        }else if (segmentIdentifier == 1){
            cell.textLabel?.text = officeData//office
                    }else if (segmentIdentifier == 2){
            cell.textLabel?.text = gymData//gym
           
            
        }
        
        // Configure the cell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell;
    }
    
    
    //if row is selected sets variable in Segment data to it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        
        if (segmentIdentifier == 0){
            data.dataFromWorkout = homeW[indexPath.row]
        }
        else if (segmentIdentifier == 1){
            data.dataFromWorkout = officeW[indexPath.row]
        }
        else if (segmentIdentifier == 2){
            data.dataFromWorkout = gymW[indexPath.row]
        }
        println(data.dataFromWorkout)
        println(" cell Selected #\(indexPath.row)!")
        
    }

    
    
    
    
    
    
    //formats and adds selected date to segment data variable
    func datePickerChanged(datePicker:UIDatePicker) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        var dateFormatter = NSDateFormatter()
        
        //datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        data.workoutTime = strDate
        println(strDate)
    }
    //determines which segment "Home, office, gym" that has been selected, changes segmentIdentifier based on users selection, reloads tableView func's for this change
    
    @IBAction func locationSegment(sender: UISegmentedControl) {
        
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            segmentIdentifier = 0
            self.tableView.reloadData()
            
        case 1:
            segmentIdentifier = 1
            self.tableView.reloadData()
            
        case 2:
            segmentIdentifier = 2
            self.tableView.reloadData()
            
        default:
            break;
        }
    }
    
    //picker view----------------
    //returns number of picker view wheels on screen
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //creates enough rows based off the size of data array
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker.count
    }
    //sets the text based of the options in the array by location, returns said location
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        
        return picker[row]
    }
    //selected rows data is sent to segmentdata variable
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        data.workoutLength = picker[row]
        println( picker[row])
    }
    //picker view------------------
    
    //cancel button on nav bar
    @IBAction func cancel(sender: AnyObject) {
        println("In cancel workout selection")
        status = "cancel"
        dismissViewControllerAnimated(true, completion: nil)
            }
    
    ////add workout button function
    @IBAction func buttonPress(sender: AnyObject) {
        println("Button pressed...will dissmiss")
        var calCheck = "false"
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        //determines which buttin was pushed and sets its ID has pressed to assist in navigating to 
        //accepted workout controller upon return to home controller
        if (data.currentButtonPressed == 1){
            data.button1Pressed = 1
        }else if (data.currentButtonPressed == 2){
            data.button2Pressed = 1
        }else if (data.currentButtonPressed == 3){
            data.button3Pressed = 1
        }else if (data.currentButtonPressed == 4){
            data.button4Pressed = 1
        }
        
        //user defaults variable
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
       println("calCheck = \(self.calCheck)")
        //gets data from user defaults
        if let firstNameIsNotNill = defaults.objectForKey("calState") as? String {
            println("test")
            calCheck = defaults.objectForKey("calState") as String
        }
        //if false will create new calender, if true will not
        if (calCheck == "false"){
        createCalendar()
        }
        addEvent()
        //activates segue to home controller
        performSegueWithIdentifier("Home", sender: self)
        }

    
    func addEvent(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        let month = components.month
        let day = components.day
        let year = components.year
        let cal : EKCalendar! = self.calendarWithName("FitIn Calendar")
        if cal == nil {
            return
        }
        
        
        
        var parsedTime = data.workoutTime.componentsSeparatedByString(":")
        var hour:String = parsedTime[0]
        var minutesAnd12Hour = parsedTime[1]
        var minutesParsed = minutesAnd12Hour.componentsSeparatedByString(" ")
        var minutes = minutesParsed[0]
        
        let hours:Int? = hour.toInt() // firstText is UITextField
        let minute:Int? = minutes.toInt() // secondText is UITextField
         let timeAmount:Int? = data.workoutLength.toInt()
        var string:String!
        // check a and b before unwrapping using !
        
        println(hours!)
        println(minute!)
        
        let greg = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)!
        let comp = NSDateComponents()
        
        comp.year = year
        comp.month = month
        comp.minute = minute!
        comp.day = day
        comp.hour = hours!
        
        let d1 = greg.dateFromComponents(comp)
        if (timeAmount! == 60){
            comp.hour = comp.hour + 1
        }else{
        comp.minute = comp.minute + timeAmount!
        }
        let d2 = greg.dateFromComponents(comp)
        
        let ev = EKEvent(eventStore:self.eventStore)
        ev.title = "Fitin Workout"
        ev.notes = data.dataFromWorkout
        ev.calendar = cal
        ev.startDate = d1
        ev.endDate = d2
        
        // we can also easily add an alarm
        let alarm = EKAlarm(relativeOffset:-3600) // one hour before
        ev.addAlarm(alarm)
        
        var err : NSError?
        let ok = self.eventStore.saveEvent(ev, span:EKSpanThisEvent, commit:true, error:&err)
        if !ok {
            println("save simple event \(err!.localizedDescription)")
            return
        }
        println("no errors")
    }
    
    func calendarWithName( name:String ) -> EKCalendar? {
        let calendars = self.eventStore.calendarsForEntityType(EKEntityTypeEvent) as [EKCalendar]
       
        
        for cal in calendars { // (should be using identifier)
            if cal.title == name {
                
                return cal
            }
        }
        println ("failed to find calendar")
        return nil
    }
    
    func createCalendar(){
        var calCheck = "false"
        var src : EKSource! = nil
         var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        for source in self.eventStore.sources() as [EKSource] {
            if source.sourceType.value == EKSourceTypeLocal.value {
                src = source
                break
            }
        }
        
        
        
        
        
        
        
        if src == nil {
            println("failed to find local source")
            return
        }
        let cal = EKCalendar(forEntityType:EKEntityTypeEvent,
            eventStore:self.eventStore)
        cal.source = src
        cal.title = "FitIn Calendar"
        // ready to save the new calendar into the database!
        var err : NSError?
        let ok = self.eventStore.saveCalendar(cal, commit:true, error:&err)
        if !ok {
            println("save calendar error: \(err!.localizedDescription)")
            return
        }
        //true confirms the calendar has been created
        calCheck = "true"
        //sets user default value as calCheck for the key calState
        defaults.setObject(calCheck, forKey: "calState")
        println("no errors")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
