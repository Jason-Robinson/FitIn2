//
//  CircleOneViewController.swift
//  Fit In
//
//  Created by Jason Robinson on 11/18/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class CircleOneViewController: UIViewController {
    
      @IBOutlet weak var button1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         var myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        self.button1.layer.cornerRadius = self.button1.frame.size.width / 2
        self.button1.clipsToBounds = true
        
        self.button1.layer.borderWidth = 3.0
        self.button1.layer.borderColor = myColor.CGColor
         
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}