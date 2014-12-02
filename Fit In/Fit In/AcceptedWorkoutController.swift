//
//  AcceptedWorkoutController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit


struct Home {
    
    var name : String
}
struct Office {
    
    var name : String
}
struct Gym {
    
    var name : String
}
class AcceptedWorkoutController:  UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    //var segData = appDelegate.getSegmentData()
    var cell:UITableViewCell!
    
    //home data
    var homes = [Home(name:"home 1"),
    Home(name:"home 2"),
    Home(name:"home 3")]
    
    //offices data
     var offices = [Office(name:"office 1"),
    Office(name:"office 2"),
    Office(name:"office 3")]
    
    //gym data
    var gyms = [Gym(name:"gym 1"),
    Gym(name:"gym 2"),
    Gym(name:"gym 3")]
    
    var segmentIdentifier = 0;
    var status = "none"
    //segmented controller outlet
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    //table view outlet
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Reload the table
        self.tableView.reloadData()
        
        //targets date picker changed function
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    //returns count of struct to set number of cells
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var result = 0
        
        //home
        if (segmentIdentifier == 0){
            result = self.homes.count
        }
        //office
        else if (segmentIdentifier == 1){
            result = self.offices.count
        }
        //gym
        else if (segmentIdentifier == 2){
            result = self.gyms.count
        }
        
        return result
    }
    
    //gets current index and adds the matching element from the struct to the table view, does this to all elements
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //ientifies which cell to use, must set Reuse ID in story board to match "Cell" <-generic name for cell
       cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        //strut objects on specific row
        let gymData = gyms[indexPath.row]
        let homeData = homes[indexPath.row]
        let officeData = offices[indexPath.row]
       
        //adds struct data to tableView
        if (segmentIdentifier == 0){
      cell.textLabel?.text = homeData.name//home
        }else if (segmentIdentifier == 1){
            cell.textLabel?.text = officeData.name//office
        }else if (segmentIdentifier == 2){
            cell.textLabel?.text = gymData.name//gym
        }
        
        // Configure the cell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return cell;
    }
    
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(" cell Selected #\(indexPath.row)!")
        
    }
    //formats and adds selected date to console log
    func datePickerChanged(datePicker:UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        var strDate = dateFormatter.stringFromDate(datePicker.date)
        println(strDate)
    }
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
        performSegueWithIdentifier("accepted", sender: self)
    }
    
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }
