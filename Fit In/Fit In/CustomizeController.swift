//
//  CustomizeController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class CustomizeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var homes = ["Workout Selection"]
    
    @IBOutlet weak var tableView: UITableView!
    var cell:UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var result = self.homes.count
        
        //home
      
        
        return result
    }
    
    //gets current index and adds the matching element from the struct to the table view, does this to all elements
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //ientifies which cell to use, must set Reuse ID in story board to match "Cell" <-generic name for cell
        cell = tableView.dequeueReusableCellWithIdentifier("customizeCell", forIndexPath: indexPath) as UITableViewCell
        
        //strut objects on specific row
        
         let homeData = homes[indexPath.row]
        //adds struct data to tableView
        
            cell.textLabel?.text = homeData//home
                
        // Configure the cell
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(" cell Selected #\(indexPath.row)!")
        
    }

    @IBAction func returnHome(sender: AnyObject) {
        performSegueWithIdentifier("customize", sender: self)
    }
    

}
