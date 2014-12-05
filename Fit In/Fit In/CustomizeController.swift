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
    
    
    var cell:UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        let alertController = UIAlertController(title: "Hey AppCoda", message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.Alert)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func showAlert(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil,  message: nil,preferredStyle: .ActionSheet)
        
        // 2
        
        let saveAction = UIAlertAction(title: "Restore Defaults", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            println("File Saved")
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            println("Cancelled")
        })
        
        
        // 4
        
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func returnToHome(segue: UIStoryboardSegue) {
        println("return to home")
    }
    @IBAction func returnHome(sender: AnyObject) {
        performSegueWithIdentifier("customize", sender: self)
    }
    

}
