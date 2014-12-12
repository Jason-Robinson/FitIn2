//
//  ViewController.swift
//  Fit In
//
//  Created by Jason Robinson on 12/11/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit

class Parse: EKEventStore {
    
    func accessGrantedForCalendar(){
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        let month = components.month
        let day = components.day
        let year = components.year
        let cal : EKCalendar! = self.calendarWithName("Calendar")
        
    }
    let eventStore = EKEventStore()
    
    func calendarWithName(name:String ) -> EKCalendar? {
        
        let calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent) as [EKCalendar]
        for cal in calendars {
            if cal.title == name {
                return cal
            }
        }
        return nil
    }
    
    func getDates(){
        
        let currDate = NSDate()
        var startDate = currDate
        var endDate=NSDate().dateByAddingTimeInterval((60*60*24)-60)
        var predicate = eventStore.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: nil)
        var eV = eventStore.eventsMatchingPredicate(predicate) as [EKEvent]!
        
        
        if eV != nil {
            for i in eV {
                println("Title  \(i.title)" )
                println("stareDate: \(i.startDate)" )
                println("endDate: \(i.endDate)" )
                
                if i.title == "Test Title" {
                    println("YES" )
                }
            }
            NSLog("events populated")
        }
        
    }
}
