//
//  AcceptedWorkoutController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit



class AcceptedWorkoutController:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var workoutSuggestion: UILabel!
    
    @IBOutlet weak var workoutTimeAmount: UILabel!
        var cell:UITableViewCell!
    
    var homeW:[String] = []
    var gymW:[String] = []
    var officeW:[String] = []
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var segmentIdentifier = 0;
    var status = "none"
    //segmented controller outlet
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //table view outlet
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        homeW = data.homeShort
        gymW = data.gymShort
        officeW = data.officeShort
        
        updateView()
        println("button + \(data.currentButtonPressed)")
        
        
        
        // Reload the table
        self.tableView.reloadData()
        
        //targets date picker changed function
       
        
    }
    func updateView(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        var eventID:String!
        var workoutLength:String!
        var dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        var strStartDate:String!
        var event = data.eventStore
        
        if (data.currentButtonPressed == 1){
            
            eventID = defaults.objectForKey("eventID1") as String?
            workoutLength = defaults.objectForKey("workoutLengthOne") as String?
            var eventData = event.eventWithIdentifier(eventID)
            strStartDate = dateFormatter.stringFromDate(eventData.startDate)
            workoutSuggestion.text = eventData.notes
            workoutTimeAmount.text = "\(strStartDate) for \(workoutLength) minutes"
            
        }else if(data.currentButtonPressed == 2){
            
            eventID = defaults.objectForKey("eventID2") as String?
            workoutLength = defaults.objectForKey("workoutLengthTwo") as String?
            var eventData = event.eventWithIdentifier(eventID)
            strStartDate = dateFormatter.stringFromDate(eventData.startDate)
            workoutSuggestion.text = eventData.notes
            workoutTimeAmount.text = "\(strStartDate) for \(workoutLength) minutes"
            
        }else if (data.currentButtonPressed == 3){
            
            eventID = defaults.objectForKey("eventID3") as String?
            workoutLength = defaults.objectForKey("workoutLengthThree") as String?
            var eventData = event.eventWithIdentifier(eventID)
            strStartDate = dateFormatter.stringFromDate(eventData.startDate)
            workoutSuggestion.text = eventData.notes
            workoutTimeAmount.text = "\(strStartDate) for \(workoutLength) minutes"
            
        }else if(data.currentButtonPressed == 4){
            
            eventID = defaults.objectForKey("eventID4") as String?
            workoutLength = defaults.objectForKey("workoutLengthFour") as String?
            var eventData = event.eventWithIdentifier(eventID)
            strStartDate = dateFormatter.stringFromDate(eventData.startDate)
            workoutSuggestion.text = eventData.notes
            workoutTimeAmount.text = "\(strStartDate) for \(workoutLength) minutes"
            
        }
        
    }
    @IBAction func editEvent (sender:AnyObject!) {
        
    }
    //returns count of struct to set number of cells
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var result = 0
        println("Hi")
        //home
        if (segmentIdentifier == 0){
            result = self.homeW.count
        }
        //office
        else if (segmentIdentifier == 1){
            result = self.officeW.count
        }
        //gym
        else if (segmentIdentifier == 2){
            result = self.gymW.count
        }
        
        return result
    }
    
    //gets current index and adds the matching element from the struct to the table view, does this to all elements
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //ientifies which cell to use, must set Reuse ID in story board to match "Cell" <-generic name for cell
       cell = tableView.dequeueReusableCellWithIdentifier("acceptedCell", forIndexPath: indexPath) as UITableViewCell
        
        //strut objects on specific row
        let gymData = gymW[indexPath.row]
        let homeData = homeW[indexPath.row]
        let officeData = officeW[indexPath.row]
       println("Segment ID: \(segmentIdentifier)")
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
       
        workoutSuggestion.text = data.dataFromWorkout
        println(" cell Selected #\(indexPath.row)!")
        
    }
    //formats and adds selected date to console log
    
    //determines which segment "Home, office, gym" that has been selected, changes segmentIdentifier based on users selection, reloads tableView func's for this change 
    @IBAction func locationSegment(sender: UISegmentedControl) {
        
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            segmentIdentifier = 0
            
            
           self.tableView.reloadData()
            
           println("seg1")
            println(segmentIdentifier)
            
        case 1:
            segmentIdentifier = 1

            self.tableView.reloadData()
            
           println("seg2")
             println(segmentIdentifier)
        case 2:
            segmentIdentifier = 2

           self.tableView.reloadData()
            
            println("seg3")
             println(segmentIdentifier)
        default:
            break;
        }
    }
    @IBAction func cancel(sender: AnyObject) {
        println("In cancel accpeted")
        status = "cancel"
       dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func openCalender(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"calshow://")!)
    }
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }
