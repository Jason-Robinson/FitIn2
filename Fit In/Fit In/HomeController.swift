//
//  HomeController.swift
//  Fit In
//
//  Created by Lexus Mans on 11/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit

class HomeController: UIViewController {

    //access the data through app delegate
    var acceptedWorkoutViewController: UIViewController?
    var workoutSelectionViewController: UIViewController?
    var authorizeViewController: UIViewController?
    
    @IBOutlet weak var namePlate: UIImageView!
    
    //var currentButtonPressed:Int = 0
    
    var button1ID = 1
    var button2ID = 2
    var button3ID = 3
    var button4ID = 4
    
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var button1Time: UILabel!
    @IBOutlet weak var button2Time: UILabel!
    @IBOutlet weak var button3Time: UILabel!
    @IBOutlet weak var button4Time: UILabel!
    @IBOutlet weak var button4Workout: UILabel!
   @IBOutlet weak var button1Workout: UILabel!
    @IBOutlet weak var button2Workout: UILabel!
    @IBOutlet weak var button3Workout: UILabel!
    let container = UIView()
    
    let redSquare = UIView()
    let blueSquare = UIView()
    let greenSquare = UIView()
    let orangeSquare = UIView()
   let graySquare = UIView()
    var returnStatus = "none"
    var TFreturn: Bool!
    
    @IBOutlet weak var testDataLbl: UILabel!
    
    
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
        //self.currentButtonPressed = 0
        
        
        //performSegueWithIdentifier("authorize", sender: self)
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
       dateLabel.text = timestamp
        
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
    //unwind segue
    override func viewWillAppear(animated: Bool) {
        println("viewWillAppear in Docs")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear in Docs")
        TFreturn = determineStatus()
        if (TFreturn == true){
            println("true")
            
        }else{
            println("false")
        }
        switch TFreturn{
        case false:
            println("false")
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AuthorizeViewController") as UIViewController;
            self.presentViewController(vc, animated: true, completion: nil)
        case true:
            println("true")
        default:
            break
        }
    }

    

    @IBAction func returnToHome(segue: UIStoryboardSegue) {
        println("return to home")
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        //println(data.dataFromWorkout)
        if (data.currentButtonPressed == 2){
            button2Workout.text = data.dataFromWorkout
            button2Time.text = data.workoutTime
        }else if(data.currentButtonPressed == 3){
            button3Workout.text = data.dataFromWorkout
            button3Time.text = data.workoutTime
        }else if(data.currentButtonPressed == 4){
            button4Workout.text = data.dataFromWorkout
            button4Time.text = data.workoutTime
        }else if (data.currentButtonPressed == 1){
            button1Workout.text = data.dataFromWorkout
            button1Time.text = data.workoutTime
        }
        
        
        
    }
    
    @IBAction func button1Filled(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        data.currentButtonPressed = 1
        println("button1Filled \(data.currentButtonPressed)")
        if ( data.button1Pressed == 1){
            acceptedWorkoutViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AcceptedWorkoutController") as AcceptedWorkoutController
            
            if (acceptedWorkoutViewController != nil ) {
                presentViewController(acceptedWorkoutViewController!, animated: true, completion: nil)
            }}
        else{
            workoutSelectionViewController = self.storyboard!.instantiateViewControllerWithIdentifier("WorkoutSelectionController") as WorkoutSelectionController
            
            if (workoutSelectionViewController != nil){
                presentViewController(workoutSelectionViewController!, animated: true, completion: nil)
            }
        }

    }
   
    
    @IBAction func button2Filled(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        data.currentButtonPressed = 2
       println(data.button2Pressed)
        if ( data.button2Pressed == 1){
        acceptedWorkoutViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AcceptedWorkoutController") as AcceptedWorkoutController
            
            if (acceptedWorkoutViewController != nil ) {
                presentViewController(acceptedWorkoutViewController!, animated: true, completion: nil)
            }}
        else{
            workoutSelectionViewController = self.storyboard!.instantiateViewControllerWithIdentifier("WorkoutSelectionController") as WorkoutSelectionController
            
            if (workoutSelectionViewController != nil){
                presentViewController(workoutSelectionViewController!, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func button3Filled(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        data.currentButtonPressed = 3
        
        if ( data.button3Pressed == 1){
            acceptedWorkoutViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AcceptedWorkoutController") as AcceptedWorkoutController
            
            if (acceptedWorkoutViewController != nil ) {
                presentViewController(acceptedWorkoutViewController!, animated: true, completion: nil)
            }}
        else{
            workoutSelectionViewController = self.storyboard!.instantiateViewControllerWithIdentifier("WorkoutSelectionController") as WorkoutSelectionController
            
            if (workoutSelectionViewController != nil){
                presentViewController(workoutSelectionViewController!, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func button4Filled(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        data.currentButtonPressed = 4
        
        if ( data.button4Pressed == 1){
            acceptedWorkoutViewController=self.storyboard!.instantiateViewControllerWithIdentifier("AcceptedWorkoutController") as AcceptedWorkoutController
            
            if (acceptedWorkoutViewController != nil ) {
                presentViewController(acceptedWorkoutViewController!, animated: true, completion: nil)
            }}
        else{
            workoutSelectionViewController = self.storyboard!.instantiateViewControllerWithIdentifier("WorkoutSelectionController") as WorkoutSelectionController
            
            if (workoutSelectionViewController != nil){
                presentViewController(workoutSelectionViewController!, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func openCalender(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string:"calshow://")!)
    }
    
    func determineStatus() -> Bool {
        let type = EKEntityTypeEvent
        let stat = EKEventStore.authorizationStatusForEntityType(type)
        switch stat {
        case .Authorized:
            println("authorized")
            return true
        case .NotDetermined:
            println("not Deter")
            return false
        case .Restricted:
            return false
        case .Denied:
            // new iOS 8 feature: sane way of getting the user directly to the relevant prefs
            // I think the crash-in-background issue is now gone
            println("Denied")
            return false
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

   
}


