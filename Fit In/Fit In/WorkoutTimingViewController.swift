//
//  WorkoutTiming.swift
//  Fit In
//
//  Created by Jason Robinson on 12/4/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class WorkoutTimingViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonPress(sender: AnyObject) {
        println("Button pressed...will dissmiss")
        performSegueWithIdentifier("Timing", sender: self)
        
        //last action of view controller
    }
    
}
