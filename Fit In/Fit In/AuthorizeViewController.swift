//
//  AuthorizeViewController.swift
//  Fit In
//
//  Created by Jason Robinson on 12/8/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit

class AuthorizeViewController: UIViewController {

    var homeController: UIViewController?
    var eventStore = EKEventStore()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        println("viewWillAppear in Docs")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        println("viewDidAppear in Docs")
        var calCheck = 0
        
        

       
        
                //println("not Authorized")
            
        
        
    }
    
    
    
    func calendar() {
        
        
        
        // 'EKEntityTypeReminder' or 'EKEntityTypeEvent'
        self.eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {
            granted, error in
            if (granted) && (error == nil) {
                println("granted \(granted)")
                println("error  \(error)")
                
            }
            
        })
        
    }
    @IBAction func authorizeButton (sender: AnyObject){
        
        let type = EKEntityTypeEvent
        let stat = EKEventStore.authorizationStatusForEntityType(type)
        
        
        if (stat == .Authorized){
        println("Authorized")
            homeController=self.storyboard!.instantiateViewControllerWithIdentifier("HomeController") as HomeController
            
            if (homeController != nil ) {
                presentViewController(homeController!, animated: true, completion: nil)
            }
        }
        else if (stat == .Denied){
            println("denied")
            let alert = UIAlertController(title: "Need Authorization", message: "Please authorize this app to use your Calendar?", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
                _ in
                let url = NSURL(string:UIApplicationOpenSettingsURLString)!
                UIApplication.sharedApplication().openURL(url)
            }))
            self.presentViewController(alert, animated:true, completion:nil)
            
        }
        else if (stat == .NotDetermined){
            println("not D")
            calendar()
        }
        else if (stat == .Restricted){
            println("Restricted")
            //calendar()
        }
       
            
    
        
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
