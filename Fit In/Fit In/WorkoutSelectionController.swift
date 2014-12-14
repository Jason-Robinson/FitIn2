//
//  WorkoutSelectionController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit



class WorkoutSelectionController: UIViewController,  UITableViewDataSource, UITableViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate {

    var calCheck = "false"
    var lengthOfWorkoutArrays = 0
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
    var homeShort:[String] = []
    var gymShort:[String] = []
    var officeShort:[String] = []
    
    var homeMedium:[String] = []
    var gymMedium:[String] = []
    var officeMedium:[String] = []
    
    var homeLong:[String] = []
    var gymLong:[String] = []
    var officeLong:[String] = []
    
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

        homeShort = data.homeShort
        gymShort = data.gymShort
        officeShort = data.officeShort
        
        homeMedium = data.homeMedium
        gymMedium = data.gymMedium
        officeMedium = data.officeMedium
        
        homeLong = data.homeLong
        gymLong = data.gymLong
        officeLong = data.officeLong

        
        self.tableView.reloadData()
        
        //targets date picker changed function
       datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    //returns number of rows based on the count of the works arrays
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var result = 15
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        //short
        if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 0) {
            result = homeShort.count
            
        }
        else if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 0){
            result = homeShort.count
        
        }
        else if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 0){
            result = homeShort.count
            
        }
        //medium
        else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 1){
            result = homeMedium.count
            
        }
        else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 1){
            result = homeMedium.count
            
        }
        else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 1){
            result = homeMedium.count
           
        }
        //long workouts
        else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 2){
            result = homeLong.count
           
        }
        else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 2){
            result = homeLong.count
            
        }
        else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 2){
            result = homeLong.count
            
        }
        return result
    }
    
    //gets current index and adds the matching element from the struct to the table view, does this to all elements
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //ientifies which cell to use, must set Reuse ID in story board to match "Cell" <-generic name for cell
        cell = tableView.dequeueReusableCellWithIdentifier("workoutCells", forIndexPath: indexPath) as UITableViewCell
        
        //strut objects on specific row
        let gymDataShort = gymShort[indexPath.row]
        let homeDataShort = homeShort[indexPath.row]
        let officeDataShort = officeShort[indexPath.row]
        
        let gymDataMedium = gymMedium[indexPath.row]
        let homeDataMedium = homeMedium[indexPath.row]
        let officeDataMedium = officeMedium[indexPath.row]
        
        let gymDataLong = gymLong[indexPath.row]
        let homeDataLong = homeLong[indexPath.row]
        let officeDataLong = officeLong[indexPath.row]
        
        //adds struct data to tableView
        if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 0){
            cell.textLabel?.text = homeDataShort//home
           
        }else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 0){
            cell.textLabel?.text = officeDataShort//office
        }else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 0){
            cell.textLabel?.text = gymDataShort//gym
           
            
        }
        
        if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 1){
            cell.textLabel?.text = homeDataMedium//home
            
        }else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 1){
            cell.textLabel?.text = officeDataMedium//office
        }else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 1){
            cell.textLabel?.text = gymDataMedium//gym
            
            
        }
        
        if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 2){
            cell.textLabel?.text = homeDataLong//home
            
        }else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 2){
            cell.textLabel?.text = officeDataLong//office
        }else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 2){
            cell.textLabel?.text = gymDataLong//gym
            
            
        }
        
        // Configure the cell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell;
    }
    
    
    //if row is selected sets variable in Segment data to it
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        
        if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 0){
            data.dataFromWorkout = homeShort[indexPath.row]
        }
        else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 0){
            data.dataFromWorkout = officeShort[indexPath.row]
        }
        else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 0){
            data.dataFromWorkout = gymShort[indexPath.row]
        }
        
        if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 1){
            data.dataFromWorkout = homeMedium[indexPath.row]
        }
        else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 1){
            data.dataFromWorkout = officeMedium[indexPath.row]
        }
        else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 1){
            data.dataFromWorkout = gymMedium[indexPath.row]
        }
        
        if (segmentIdentifier == 0 && self.lengthOfWorkoutArrays == 2){
            data.dataFromWorkout = homeLong[indexPath.row]
        }
        else if (segmentIdentifier == 1 && self.lengthOfWorkoutArrays == 2){
            data.dataFromWorkout = officeLong[indexPath.row]
        }
        else if (segmentIdentifier == 2 && self.lengthOfWorkoutArrays == 2){
            data.dataFromWorkout = gymLong[indexPath.row]
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
        //data.start = dateFormatter.dateFromString(strDate)
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
        
         var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if (picker[row] != ""){
        data.workoutLength = picker[row]
        }else{
            data.workoutLength = "5"
        }
        
        
        if (data.workoutLength.toInt() >= 5 && data.workoutLength.toInt() < 20){
            self.lengthOfWorkoutArrays = 0
             self.tableView.reloadData()
        }else if (data.workoutLength.toInt() >= 20 && data.workoutLength.toInt() < 40){
            self.lengthOfWorkoutArrays = 1
             self.tableView.reloadData()
        }else if (data.workoutLength.toInt() >= 40 && data.workoutLength.toInt() <= 60){
            self.lengthOfWorkoutArrays = 2
            self.tableView.reloadData()
        }
       
        
        
        
        
        
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
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
       
        //determines which buttin was pushed and sets its ID has pressed to assist in navigating to 
        //accepted workout controller upon return to home controller
        if (data.currentButtonPressed == 1){
            
            data.button1Pressed = 1
            defaults.setInteger(data.button1Pressed, forKey: "buttonOne")
            
            
        }else if (data.currentButtonPressed == 2){
            
            data.button2Pressed = 1
            defaults.setInteger(data.button2Pressed, forKey: "buttonTwo")
            
        }else if (data.currentButtonPressed == 3){
            
            data.button3Pressed = 1
            defaults.setInteger(data.button3Pressed, forKey: "buttonThree")
            
        }else if (data.currentButtonPressed == 4){
            
            data.button4Pressed = 1
            defaults.setInteger(data.button4Pressed, forKey: "buttonFour")
            
        }
        
        //user defaults variable
        
        //gets data from user defaults
        
        
        
        data.addEvent(data.currentButtonPressed)
        //activates segue to home controller
        performSegueWithIdentifier("Home", sender: self)
        }

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
