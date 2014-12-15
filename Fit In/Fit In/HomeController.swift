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
    
    
    @IBOutlet weak var namePlate: UIImageView!
    
    //var currentButtonPressed:Int = 0
    
    @IBOutlet weak var dateLabel: UILabel!
    var button1ID = 1
    var button2ID = 2
    var button3ID = 3
    var button4ID = 4
    
    var buttonOneTime:String!
    var buttonTwoTime:String!
    var buttonThreeTime:String!
    var buttonFourTime:String!
    
    var buttonOneLength:String!
    var buttonTwoLength:String!
    var buttonThreeLength:String!
    var buttonFourLength:String!
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var acceptedWorkoutViewController: UIViewController?
    var workoutSelectionViewController: UIViewController?
    var authorizeViewController: UIViewController?
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    let container = UIView()
    
    
   
    var returnStatus = "none"
    var TFreturn: Bool!
    
    //bubble container variables from UI
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    @IBOutlet weak var container3: UIView!
    @IBOutlet weak var container4: UIView!
    
    
    //bubble variables from Bubble.swift
    let topLeftBubble = NSBundle.mainBundle().loadNibNamed("Bubble", owner: nil, options: nil).first as Bubble
    let topRightBubble = NSBundle.mainBundle().loadNibNamed("Bubble", owner: nil, options: nil).first as Bubble
    let bottomLeftBubble = NSBundle.mainBundle().loadNibNamed("Bubble", owner: nil, options: nil).first as Bubble
    let bottomRightBubble = NSBundle.mainBundle().loadNibNamed("Bubble", owner: nil, options: nil).first as Bubble
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        
        //checks if event ID's have been set from nil, if not then NSUserDefaults for the ID's are set to ""
        if (self.defaults.objectForKey("eventID1") == nil && self.defaults.objectForKey("eventID1") == nil && self.defaults.objectForKey("eventID1") == nil && self.defaults.objectForKey("eventID1") == nil ){
                self.defaults.setObject(data.eventIDButton1, forKey: "eventID1")
                self.defaults.setObject(data.eventIDButton2, forKey: "eventID2")
                self.defaults.setObject(data.eventIDButton3, forKey: "eventID3")
                self.defaults.setObject(data.eventIDButton4, forKey: "eventID4")
        }
        
        //
        checkEventState()
        //performSegueWithIdentifier("authorize", sender: self)
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .NoStyle)
        dateLabel.text = timestamp
        
        //Set the Bubbles' attributes and adding them to the view
        let topLeftBubbleSize = topLeftBubble.frame.size
        let topLeftBubbleRect = CGRectMake(container1.frame.origin.x, container1.frame.origin.y, topLeftBubbleSize.width, topLeftBubbleSize.height)
        topLeftBubble.frame = topLeftBubbleRect
        topLeftBubble.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(topLeftBubble)
        
        let topRightBubbleSize = topRightBubble.frame.size
        let topRightBubbleRect = CGRectMake(container2.frame.origin.x, container2.frame.origin.y, topRightBubbleSize.width, topRightBubbleSize.height)
        topRightBubble.frame = topRightBubbleRect
        topRightBubble.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(topRightBubble)
        
        let bottomLeftBubbleSize = bottomLeftBubble.frame.size
        let bottomLeftBubbleRect = CGRectMake(container3.frame.origin.x, container3.frame.origin.y, bottomLeftBubbleSize.width, bottomLeftBubbleSize.height)
        bottomLeftBubble.frame = bottomLeftBubbleRect
        bottomLeftBubble.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(bottomLeftBubble)
        
        let bottomRightBubbleSize = bottomRightBubble.frame.size
        let bottomRightBubbleRect = CGRectMake(container4.frame.origin.x, container4.frame.origin.y, bottomRightBubbleSize.width, bottomRightBubbleSize.height)
        bottomRightBubble.frame = bottomRightBubbleRect
        bottomRightBubble.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(bottomRightBubble)
        
        //Creating gesture recognition for the Bubbles to act in the place of buttons
        let aSelector : Selector = "button1Filled:"
        let bSelector : Selector = "button2Filled:"
        let cSelector : Selector = "button3Filled:"
        let dSelector : Selector = "button4Filled:"
        let atapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        atapGesture.numberOfTapsRequired = 1
        let btapGesture = UITapGestureRecognizer(target: self, action: bSelector)
        btapGesture.numberOfTapsRequired = 1
        let ctapGesture = UITapGestureRecognizer(target: self, action: cSelector)
        ctapGesture.numberOfTapsRequired = 1
        let dtapGesture = UITapGestureRecognizer(target: self, action: dSelector)
        dtapGesture.numberOfTapsRequired = 1
        topLeftBubble.addGestureRecognizer(atapGesture)
        bottomLeftBubble.addGestureRecognizer(ctapGesture)
        topRightBubble.addGestureRecognizer(btapGesture)
        bottomRightBubble.addGestureRecognizer(dtapGesture)
        
        //Create the UIDynamicAnimator to use animations
        self.animator = UIDynamicAnimator(referenceView: self.view)
        //Creates the gravity behavior and applies it to the Bubbles
        self.gravity = UIGravityBehavior(items: [topLeftBubble, topRightBubble, bottomLeftBubble, bottomRightBubble]);
        //Sets the gravity's magnitude so the Bubbles move slower
        self.gravity?.magnitude=0.1
        
        //Create instantaneous pushes for the Bubbles so they bounce around rather than up and down
        let instantaneousPush: UIPushBehavior = UIPushBehavior(items: [topRightBubble, bottomRightBubble], mode: UIPushBehaviorMode.Instantaneous)
        instantaneousPush.setAngle(CGFloat(3.14159), magnitude: 1.167)
        let instantaneousPush2: UIPushBehavior = UIPushBehavior(items: [topLeftBubble, bottomLeftBubble], mode: UIPushBehaviorMode.Instantaneous)
        instantaneousPush2.setAngle(CGFloat(0), magnitude: 1.167)
        
        //Creates collisions that apply to the Bubbles
        self.collision = UICollisionBehavior(items: [topLeftBubble, topRightBubble, bottomLeftBubble, bottomRightBubble]);
        self.collision?.translatesReferenceBoundsIntoBoundary=true
        //The boundary in the horizontal middle of the bubbles
        self.collision?.addBoundaryWithIdentifier("CenterHorizontal", fromPoint: CGPointMake(self.container3.frame.origin.x - 40, self.container3.frame.origin.y+40), toPoint: CGPointMake(self.container4.center.x + 40 + self.container4.frame.width, self.container4.frame.origin.y+40))
        //Boundary above all bubbles
        self.collision?.addBoundaryWithIdentifier("TopHorizontal", fromPoint: CGPointMake(self.container1.frame.origin.x - 40, self.container1.frame.origin.y-35), toPoint: CGPointMake(self.container2.center.x + 40 + self.container2.frame.width, self.container2.frame.origin.y-35))
        //Boundary at the veritcal middle of the bubbles
        self.collision?.addBoundaryWithIdentifier("CenterVertical", fromPoint: CGPointMake(self.container1.frame.origin.x + self.container1.frame.width + 30, self.container1.frame.origin.y-300), toPoint: CGPointMake(self.container1.frame.origin.x + self.container1.frame.width + 30, self.container3.frame.origin.y+300))
        //Boundary below all bubbles
        self.collision?.addBoundaryWithIdentifier("BottomHorizontal", fromPoint: CGPointMake(self.container3.frame.origin.x - 40, self.container3.frame.origin.y+225), toPoint: CGPointMake(self.container4.frame.origin.x + 40 + self.container4.frame.width, self.container4.frame.origin.y+225))
        //Far left boundary
        self.collision?.addBoundaryWithIdentifier("LeftVertical", fromPoint: CGPointMake(self.view.frame.origin.x + 35, self.view.frame.origin.y), toPoint: CGPointMake(self.view.frame.origin.x + 35, self.view.frame.origin.y + self.view.frame.height))
        //Far right boundary
        self.collision?.addBoundaryWithIdentifier("RightVertical", fromPoint: CGPointMake(self.view.frame.origin.x + self.view.frame.width - 35, self.view.frame.origin.y), toPoint: CGPointMake(self.view.frame.origin.x + self.view.frame.width - 35, self.view.frame.origin.y + self.view.frame.height))
        
        //Adding additional behaviors to the bubbles
        var itemBehavior = UIDynamicItemBehavior(items: [topLeftBubble, topRightBubble, bottomLeftBubble, bottomRightBubble]);
        //Stops rotation as they bounce and fall
        itemBehavior.allowsRotation = false;
        //Makes collisions completely elastic so no energy is lost
        itemBehavior.elasticity = 1.0;
        //Set resistance and friction to 0 so they don't slow
        itemBehavior.resistance = 0.0;
        itemBehavior.friction = 0.0;
        self.animator!.addBehavior(itemBehavior)
        self.animator!.addBehavior(self.collision)
        self.animator!.addBehavior(self.gravity)
        self.animator!.addBehavior(instantaneousPush)
        self.animator!.addBehavior(instantaneousPush2)        // Do any additional setup after loading the view.
        
    }
    //unwind segue
    override func viewWillAppear(animated: Bool) {
        println("viewWillAppear in Docs")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear in Docs")
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        
        checkEventState()
        updateButtonColor()
        
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

    func buttonResize(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        if (data.currentButtonPressed == 2){
            //If the workout is 20 minutes or less, this logic makes the bubble small
            if (data.workoutLength.toInt()<=20)
            {
                self.topRightBubble.frame = CGRectMake(container2.frame.origin.x, container2.frame.origin.y, container2.frame.size.width, container2.frame.size.height)
            }
                //If the workout is between 20 and 40, this logic makes the bubble medium
            else if (data.workoutLength.toInt()<=40)
            {
                self.topRightBubble.frame = CGRectMake(container2.frame.origin.x - 10, container2.frame.origin.y - 10, container2.frame.size.width + 20, container2.frame.size.height + 20)
            }
                //If the workout is between 40 and 60, this logic makes the bubble large
            else
            {
                self.topRightBubble.frame = CGRectMake(container2.frame.origin.x - 20, container2.frame.origin.y - 20 - 10, container2.frame.size.width + 40, container2.frame.size.height + 40)
            }
            
            //Sets the selected workout data to the Bubble's labels and changes the bubble's color
            self.topRightBubble.exerciseLabel?.text = data.dataFromWorkout
            self.topRightBubble.timeLabel?.text = data.workoutTime
            self.topRightBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
            
        }
            
        else if(data.currentButtonPressed == 3){
            if (data.workoutLength.toInt()<=20)
            {
                self.bottomLeftBubble.frame = CGRectMake(container3.frame.origin.x, container3.frame.origin.y, container3.frame.size.width, container3.frame.size.height)
            }
                
            else if (data.workoutLength.toInt()<=40)
            {
                self.bottomLeftBubble.frame = CGRectMake(container3.frame.origin.x - 10, container3.frame.origin.y - 10, container3.frame.size.width + 20, container3.frame.size.height + 20)
            }
                
            else
            {
                self.bottomLeftBubble.frame = CGRectMake(container3.frame.origin.x - 20, container3.frame.origin.y - 20 + 10, container3.frame.size.width + 40, container3.frame.size.height + 40)
            }
            
            self.bottomLeftBubble.exerciseLabel?.text = data.dataFromWorkout
            self.bottomLeftBubble.timeLabel?.text = data.workoutTime
            self.bottomLeftBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        }
            
        else if(data.currentButtonPressed == 4){
            if (data.workoutLength.toInt() < 20)
            {
                self.bottomRightBubble.frame = CGRectMake(container4.frame.origin.x, container4.frame.origin.y, container4.frame.size.width, container4.frame.size.height)
            }
                
            else if (data.workoutLength.toInt() < 40)
            {
                self.bottomRightBubble.frame = CGRectMake(container4.frame.origin.x - 10, container4.frame.origin.y - 10, container4.frame.size.width + 20, container4.frame.size.height + 20)
            }
                
            else
            {
                self.bottomRightBubble.frame = CGRectMake(container4.frame.origin.x - 20, container4.frame.origin.y - 20 + 10, container4.frame.size.width + 40, container4.frame.size.height + 40)
            }
            
            self.bottomRightBubble.exerciseLabel?.text = data.dataFromWorkout
            self.bottomRightBubble.timeLabel?.text = data.workoutTime
            
            
            self.bottomRightBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        }
            
        else if (data.currentButtonPressed == 1){
            if (data.workoutLength.toInt()<=20)
            {
                self.topLeftBubble.frame = CGRectMake(container1.frame.origin.x, container1.frame.origin.y, container1.frame.size.width, container1.frame.size.height)
            }
                
            else if (data.workoutLength.toInt()<=40)
            {
                self.topLeftBubble.frame = CGRectMake(container1.frame.origin.x - 10, container1.frame.origin.y - 10, container1.frame.size.width + 20, container1.frame.size.height + 20)
            }
                
            else
            {
                self.topLeftBubble.frame = CGRectMake(container1.frame.origin.x - 20, container1.frame.origin.y - 20 - 10, container1.frame.size.width + 40, container1.frame.size.height + 40)
            }
            
            self.topLeftBubble.exerciseLabel?.text = data.dataFromWorkout
            self.topLeftBubble.timeLabel?.text = data.workoutTime
            self.topLeftBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        }
        
        
        
        
    }

    
    
    @IBAction func returnToHome(segue: UIStoryboardSegue) {
        println("return to home")
        buttonResize()
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        data.deleteEvent()
        //println(data.dataFromWorkout)
        
        
        
    }
    
    @IBAction func button1Filled(sender: AnyObject) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        var event = data.eventStore
        
        
       
        
        var dateFormatter = NSDateFormatter()
        
        //datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        
        
        
        var buttonPressOne = self.defaults.integerForKey("buttonOne")
        var eventID = self.defaults.objectForKey("eventID1") as String?
        
        if (eventID == ""){
            
            buttonPressOne = 0
            println(buttonPressOne)
            
        }
        
        
        data.currentButtonPressed = 1
       println(buttonPressOne)
        if ( buttonPressOne == 1){
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
        
        
        
        
        var buttonPressTwo = self.defaults.integerForKey("buttonTwo")
        var eventID = self.defaults.objectForKey("eventID2") as String?
       
        if (eventID == ""){
            buttonPressTwo = 0
        }
        
        data.currentButtonPressed = 2
        
       
        if ( buttonPressTwo == 1){
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
        
        var buttonPressThree = self.defaults.integerForKey("buttonThree")
        var eventID = self.defaults.objectForKey("eventID3") as String?
        
        if (eventID == ""){
            buttonPressThree = 0
        }
        data.currentButtonPressed = 3
        
        if ( buttonPressThree == 1){
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
    //when button 4 is clicked, bottom right
    @IBAction func button4Filled(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        
        //gets value from NSUserDefaults based on key
        var buttonPressFour = self.defaults.integerForKey("buttonFour")
        var eventID = self.defaults.objectForKey("eventID4") as String?
        
        //sets segment data button pressed to 4
        data.currentButtonPressed = 4
        //signifies if event has been deleted
        if (eventID == ""){
            buttonPressFour = 0
        }
        if ( buttonPressFour == 1){
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
    
    
    // opens calender if Calendar button is clicked
    @IBAction func openCalender(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string:"calshow://")!)
    }
    
    //determines status of iCal access granted
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
            println("Denied")
            return false
        }
    }
    /*
      updates button color depending if there is an existing event for the button, if yes then
      changes to blue, if not stays orange. Resizes buttons if view is changed or app closed
    */
    func updateButtonColor(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        
        //button event ID's
        println("here")
        var buttonOne: String!
        buttonOne = self.defaults.objectForKey("eventID1") as String?
        var buttonTwo: String!
        buttonTwo = self.defaults.objectForKey("eventID2") as String?
        var buttonThree: String!
        buttonThree = self.defaults.objectForKey("eventID3") as String?
        var buttonFour: String!
        buttonFour = self.defaults.objectForKey("eventID4") as String?
        println("Here3")
        
        //if button one ID doesn't equal empty string, meaning there is an event, resizes button after view is changed for app is closed
        if (   self.defaults.objectForKey("eventID1") as String? != "" )
        {
            println("Onnneee")
            println(self.defaults.objectForKey("eventID1") as String?)
            self.topLeftBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
            
            if (self.defaults.integerForKey("workoutLengthOne") < 20)
            {
                self.topLeftBubble.frame = CGRectMake(container4.frame.origin.x, container4.frame.origin.y, container4.frame.size.width, container4.frame.size.height)
            }
                
            else if (self.defaults.integerForKey("workoutLengthOne") < 40)
            {
                self.topLeftBubble.frame = CGRectMake(container4.frame.origin.x - 10, container4.frame.origin.y - 10, container4.frame.size.width + 20, container4.frame.size.height + 20)
            }
                
            else
            {
                self.topLeftBubble.frame = CGRectMake(container4.frame.origin.x - 20, container4.frame.origin.y - 20 + 10, container4.frame.size.width + 40, container4.frame.size.height + 40)
            }
            
        }else{
            
            
            self.topLeftBubble.backgroundColor = UIColor.orangeColor()
            self.topLeftBubble.timeLabel?.text = "Select"
            self.topLeftBubble.exerciseLabel?.text = "Workout"
           
        }
        //if button two ID doesn't equal empty string, meaning there is an event, resizes button after view is changed for app is closed
        if ( self.defaults.objectForKey("eventID2") as String? != "" )
        {
            println("Twooooo")
            println(self.defaults.objectForKey("eventID2") as String?)
            self.topRightBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
            if (self.defaults.integerForKey("workoutLengthTwo") < 20)
            {
                self.topRightBubble.frame = CGRectMake(container4.frame.origin.x, container4.frame.origin.y, container4.frame.size.width, container4.frame.size.height)
            }
                
            else if (self.defaults.integerForKey("workoutLengthTwo") < 40)
            {
                self.topRightBubble.frame = CGRectMake(container4.frame.origin.x - 10, container4.frame.origin.y - 10, container4.frame.size.width + 20, container4.frame.size.height + 20)
            }
                
            else
            {
                self.topRightBubble.frame = CGRectMake(container4.frame.origin.x - 20, container4.frame.origin.y - 20 + 10, container4.frame.size.width + 40, container4.frame.size.height + 40)
            }
            
        }else{
            
            self.topRightBubble.backgroundColor = UIColor.orangeColor()
            self.topRightBubble.timeLabel?.text = "Select"
            self.topRightBubble.exerciseLabel?.text = "Workout"
            
        }
        
        //if button three ID doesn't equal empty string, meaning there is an event, resizes button after view is changed for app is closed
        if ( self.defaults.objectForKey("eventID3") as String? != "" )
        {
            println("Three")
            println(self.defaults.objectForKey("eventID3") as String?)
            self.bottomLeftBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
            //less than 20 minute workout
            if (self.defaults.integerForKey("workoutLengthThree") < 20)
            {
                self.bottomLeftBubble.frame = CGRectMake(container4.frame.origin.x, container4.frame.origin.y, container4.frame.size.width, container4.frame.size.height)
            }
            //less than 40 minute workouts
            else if (self.defaults.integerForKey("workoutLengthThree") < 40)
            {
                self.bottomLeftBubble.frame = CGRectMake(container4.frame.origin.x - 10, container4.frame.origin.y - 10, container4.frame.size.width + 20, container4.frame.size.height + 20)
            }
            //40-60 minute workouts
            else
            {
                self.bottomLeftBubble.frame = CGRectMake(container4.frame.origin.x - 20, container4.frame.origin.y - 20 + 10, container4.frame.size.width + 40, container4.frame.size.height + 40)
            }
        
        }else{
            
            self.bottomLeftBubble.backgroundColor = UIColor.orangeColor()
            self.bottomLeftBubble.timeLabel?.text = "Select"
            self.bottomLeftBubble.exerciseLabel?.text = "Workout"
           
        }
       
        //if button four ID doesn't equal empty string, meaning there is an event, resizes button after view is changed for app is closed
        if ( self.defaults.objectForKey("eventID4") as String? != "" )
        {
            println("Four")
            println( self.defaults.objectForKey("eventID4") as String?)
            self.bottomRightBubble.backgroundColor=UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
            if (self.defaults.integerForKey("workoutLengthFour") < 20)
            {
                self.bottomRightBubble.frame = CGRectMake(container4.frame.origin.x, container4.frame.origin.y, container4.frame.size.width, container4.frame.size.height)
            }
                
            else if (self.defaults.integerForKey("workoutLengthFour") < 40)
            {
                self.bottomRightBubble.frame = CGRectMake(container4.frame.origin.x - 10, container4.frame.origin.y - 10, container4.frame.size.width + 20, container4.frame.size.height + 20)
            }
                
            else
            {
                self.bottomRightBubble.frame = CGRectMake(container4.frame.origin.x - 20, container4.frame.origin.y - 20 + 10, container4.frame.size.width + 40, container4.frame.size.height + 40)
            }
           
        }else{
            
            self.bottomRightBubble.backgroundColor = UIColor.orangeColor()
            self.bottomRightBubble.timeLabel?.text = "Select"
            self.bottomRightBubble.exerciseLabel?.text = "Workout"
            
           
        }
        

        
    }
    //finds all events based off event identifiers set in addEvent (SegmentData.swift).
    //if not nil, returns event data to add workout start time to bubbles
    func checkEventState(){
    
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let data = appDelegate.getSegmentData()
        var dateFormatter = NSDateFormatter()
        var event = data.eventStore
       
        
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        //button 1
        var eventIDOne = self.defaults.objectForKey("eventID1") as String?
        var findEventOne =  event.eventWithIdentifier(eventIDOne)
        
        if (findEventOne != nil){
            
            var strStartDate = dateFormatter.stringFromDate(findEventOne.startDate)
            self.buttonOneTime = strStartDate
            self.topLeftBubble.timeLabel?.text = strStartDate
            
            
        }
        
        
        //button 2
        var eventIDTwo = self.defaults.objectForKey("eventID2") as String?
        var findEventTwo =  event.eventWithIdentifier(eventIDTwo)
        if (findEventTwo != nil){
            
            var strStartDate = dateFormatter.stringFromDate(findEventTwo.startDate)
            self.buttonTwoTime = strStartDate
            self.topRightBubble.timeLabel?.text = strStartDate
            

        }
        
        //button 3
        var eventIDThree = self.defaults.objectForKey("eventID3") as String?
        var findEventThree =  event.eventWithIdentifier(eventIDThree)
        
        if (findEventThree != nil){
            
            var strStartDate = dateFormatter.stringFromDate(findEventThree.startDate)
            self.buttonThreeTime = strStartDate
            self.bottomLeftBubble.timeLabel?.text = strStartDate
            

            
        }
        
        //button 4
        var eventIDFour = self.defaults.objectForKey("eventID4") as String?
        var findEventFour =  event.eventWithIdentifier(eventIDFour)
        
        if (findEventFour != nil){
            
            
            var strStartDate = dateFormatter.stringFromDate(findEventFour.startDate)
            
            self.buttonFourTime = strStartDate
            self.bottomRightBubble.timeLabel?.text = strStartDate
            

        }
       
       
        

    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

   
}


