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
    
    //var segData = appDelegate.getSegmentData()
    var cell:UITableViewCell!
    
    var homes = [Home(name:"home 1"),
    Home(name:"home 2"),
    Home(name:"home 3")]
    
     var offices = [Office(name:"office 1"),
    Office(name:"office 2"),
    Office(name:"office 3")]
    
    var gyms = [Gym(name:"gym 1"),
    Gym(name:"gym 2"),
    Gym(name:"gym 3")]
    
    var segmentIdentifier = 0;
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Reload the table
        self.tableView.reloadData()
        
        
    }
    
      func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3 //Currently Giving default Value
    }
    
    
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
       cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        
        let gymData = gyms[indexPath.row]
        let homeData = homes[indexPath.row]
        let officeData = offices[indexPath.row]
       
       cell.textLabel.text = gymData.name
        
        // Configure the cell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return cell;
    }
    
      func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(" cell Selected #\(indexPath.row)!")
    }
    
    
    @IBAction func locationSegment(sender: UISegmentedControl) {
        
        
        
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            segmentIdentifier = 0
            
            
            //cell.textLabel.text = homes.name
            
           println("seg1")
            println(segmentIdentifier)
            
        case 1:
            segmentIdentifier = 1

            // cell.textLabel.text = officeData.name
            
           println("seg2")
             println(segmentIdentifier)
        case 2:
            segmentIdentifier = 2

           // cell.textLabel.text = gymData.name
            
            println("seg3")
             println(segmentIdentifier)
        default:
            break;
        }
    }
    
    
    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }
