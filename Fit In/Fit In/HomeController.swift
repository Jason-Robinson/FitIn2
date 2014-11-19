//
//  HomeController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    let container = UIView()
    let redSquare = UIView()
    let blueSquare = UIView()
    let greenSquare = UIView()
    let orangeSquare = UIView()
   let graySquare = UIView()
    
    @IBOutlet weak var container1: UIView!
    
    @IBOutlet weak var container2: UIView!
   
    @IBOutlet weak var container3: UIView!
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var container4: UIView!
    
    @IBOutlet weak var button2: UIButton!
  
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.container.frame = CGRect(x: 60, y: 60, width: 200, height: 200)
        //self.view.addSubview(container)
        //self.view.addSubview(container1)
        // set red square frame up
        // we want the blue square to have the same position as redSquare
        // so lets just reuse blueSquare.frame
        self.redSquare.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.blueSquare.frame = redSquare.frame
        self.greenSquare.frame = redSquare.frame
        self.orangeSquare.frame = redSquare.frame
        
        //self.button2.frame = redSquare.frame
        // set background colors
        self.redSquare.backgroundColor = UIColor.redColor()
        self.blueSquare.backgroundColor = UIColor.blueColor()
        self.greenSquare.backgroundColor = UIColor.greenColor()
        self.orangeSquare.backgroundColor = UIColor.orangeColor()
        
        
        
        
        
        // for now just add the redSquare
        // we'll add blueSquare as part of the transition animation
        self.container1.layer.cornerRadius = self.container1.frame.size.width / 2
        self.container1.clipsToBounds = true
        
        self.container2.layer.cornerRadius = self.container2.frame.size.width / 2
        self.container2.clipsToBounds = true
        
        self.container3.layer.cornerRadius = self.container3.frame.size.width / 2
        self.container3.clipsToBounds = true
        
        self.container4.layer.cornerRadius = self.container4.frame.size.width / 2
        self.container4.clipsToBounds = true
        
        var myColor : UIColor = UIColor( red: 0.5, green: 0.5, blue:0, alpha: 1.0 )
        
        //button
        self.button1.layer.cornerRadius = self.button1.frame.size.width / 2
        self.button1.clipsToBounds = true
        
        self.button2.layer.cornerRadius = self.button2.frame.size.width / 2
        self.button2.clipsToBounds = true
        
        self.button3.layer.cornerRadius = self.button3.frame.size.width / 2
        self.button3.clipsToBounds = true
        
        self.button4.layer.cornerRadius = self.button4.frame.size.width / 2
        self.button4.clipsToBounds = true
        
        self.button1.layer.borderWidth = 3.0
        self.button1.layer.borderColor = myColor.CGColor
        
        self.button2.layer.borderWidth = 3.0
        self.button2.layer.borderColor = myColor.CGColor
        
        self.button3.layer.borderWidth = 3.0
        self.button3.layer.borderColor = myColor.CGColor
        
        self.button4.layer.borderWidth = 3.0
        self.button4.layer.borderColor = myColor.CGColor
        
        
        self.container1.addSubview(self.redSquare)
        self.container1.addSubview(self.button1)
        
        self.container2.addSubview(self.blueSquare)
        self.container2.addSubview(self.button2)
        
        self.container3.addSubview(self.greenSquare)
        self.container3.addSubview(self.button3)
        
        self.container4.addSubview(self.orangeSquare)
        self.container4.addSubview(self.button4)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

   
}


