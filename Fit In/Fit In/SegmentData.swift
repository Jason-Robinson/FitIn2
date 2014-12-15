//
//  SegmentData.swift
//  Fit In
//
//  Created by Jason Robinson on 11/24/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit
import EventKitUI

class SegmentData: NSObject {
   
   var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var eventStore = EKEventStore()
    var eventIDButton1 = ""
    var eventIDButton2 = ""
    var eventIDButton3 = ""
    var eventIDButton4 = ""
    
    
    //work options
    var gymShort: [String] = ["Easy - 15 squats","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var homeShort: [String] = ["Easy - 15 squats","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var officeShort: [String] = ["Easy - 15 squats","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var gymMedium: [String] = ["gym medium","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var homeMedium: [String] = ["home Medium","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var officeMedium: [String] = ["office medium","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var gymLong: [String] = ["gym long", "Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var homeLong: [String] = ["home long","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var officeLong: [String] = ["office long","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
   
    //workout selection from workoutSelectionViewController
    var dataFromWorkout:String = "Didn't Select A Workout"
    //time of day from workoutSelectionViewController
    var workoutTime:String = "12:00 PM"
    //length of workout from workoutSelectionViewController
    var workoutLength = "5"
    //beginning time to start workouts, default
    var workoutTimingStart = "9:00 AM"
    //ending time for workouts to start
    var workoutTimingEnd = "5:00 PM"
    //time when daily reminder will be, default
    var dailyReminderTime = "8:00 AM"
    //butoon that has most recenty been pushed
    var currentButtonPressed = 0
    //button IDs
    var button1Pressed = 0
    var button2Pressed = 0
    var button3Pressed = 0
    var button4Pressed = 0
    var start:NSDate!
    var end:NSDate!
    //minimum workout time in WorkoutTimeController
    var minWorkoutTime = 0
    
    var array:[String] = ["","","","","","","","","","","","",""]
    var arrayEnd:[String] = ["","","","","","","","","","","","",""]
    
    func addEvent(buttonPressed:Int){
        
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay, fromDate: date)
        let month = components.month
        let day = components.day
        let year = components.year
        let cal : EKCalendar! = self.calendarWithName("Calendar")
        if cal == nil {
            return
        }
        
        
        self.defaults.setInteger(currentButtonPressed, forKey:("currentButton"))
        currentButtonPressed = self.defaults.integerForKey("currentButton")
        
        var parsedTime = self.workoutTime.componentsSeparatedByString(":")
        var hour:String = parsedTime[0]
        var minutesAnd12Hour = parsedTime[1]
        var minutesParsed = minutesAnd12Hour.componentsSeparatedByString(" ")
        var minutes = minutesParsed[0]
        
        let hours:Int? = hour.toInt()
        let minute:Int? = minutes.toInt()
        let timeAmount:Int? = self.workoutLength.toInt()
        var string:String!
        
        
        println(hours!)
        println(minute!)
        
        let greg = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)!
        let comp = NSDateComponents()
        
        comp.year = year
        comp.month = month
        comp.minute = minute!
        comp.day = day
        println(minutesParsed[1])
        //adjusts for 12 hr time format
        if (minutesParsed[1] == "PM" && hours! != 12){
            comp.hour = hours! + 12
        }else{
            comp.hour = hours!
        }
        
        let start = greg.dateFromComponents(comp)
        if (timeAmount! == 60){
            comp.hour = comp.hour + 1
        }else{
            comp.minute = comp.minute + timeAmount!
        }
        let end = greg.dateFromComponents(comp)
        
        let ev = EKEvent(eventStore:self.eventStore)
        ev.title = "FitWhen Workout"
        ev.notes = self.dataFromWorkout
        ev.calendar = cal
        ev.startDate = start
        ev.endDate = end
        
        // we can also easily add an alarm
        let alarm = EKAlarm(relativeOffset:-3600) // one hour before
        ev.addAlarm(alarm)
        
        var err : NSError?
        let ok = self.eventStore.saveEvent(ev, span:EKSpanThisEvent, commit:true, error:&err)
       
        //initialize defaults
        
        
        //set defaults
        if (buttonPressed == 1){
            self.eventIDButton1 = ev.eventIdentifier
            println("heeeeee" + self.eventIDButton1)
            self.defaults.setObject(self.eventIDButton1, forKey: "eventID1")
        }else if(buttonPressed == 2){
            self.eventIDButton2 = ev.eventIdentifier
            self.defaults.setObject(self.eventIDButton2, forKey: "eventID2")
        }else if (buttonPressed == 3){
            self.eventIDButton3 = ev.eventIdentifier
            self.defaults.setObject(self.eventIDButton3, forKey: "eventID3")
        }else if (buttonPressed == 4){
            self.eventIDButton4 = ev.eventIdentifier
            self.defaults.setObject(self.eventIDButton4, forKey: "eventID4")
        }
        
        

        
        if !ok {
            println("save simple event \(err!.localizedDescription)")
            
            return
        }
        println("no errors")
    }
    
    
    func calendarWithName( name:String ) -> EKCalendar? {
        let calendars = self.eventStore.calendarsForEntityType(EKEntityTypeEvent) as [EKCalendar]
        
        
        for cal in calendars { // (should be using identifier)
            if cal.title == "Calendar" {
                
                return cal
            }
        }
        println ("failed to find calendar")
        return nil
    }
    func createReminder(){
        var store = EKEventStore()
        var start = NSDate()
        // Reminder
        let cal : EKCalendar! = self.calendarWithName("Calendar")
        var reminder = EKReminder(eventStore: self.eventStore)
        reminder.title = "Test"
        reminder.calendar = cal
       
        let today = NSDate()
        let greg = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)!
        // day without time means "all day"
        let comps : NSCalendarUnit = .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit
        //comps.
        reminder.dueDateComponents = greg.components(comps, fromDate:today)
        // Add alarm to reminder
       
        
        // Add it to Reminders.app
        var error:NSErrorPointer = NSErrorPointer()
        eventStore.saveReminder(reminder, commit: true, error:error)
    }
    
    func deleteEvent(){
        
        let cal : EKCalendar! = self.calendarWithName("Calendar")
            
        let event = EKEvent(eventStore: self.eventStore)
        if cal == nil {
            return
        }
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .MediumStyle
        
        var startDate=NSDate().dateByAddingTimeInterval(-60*60*24)
        var endDate=NSDate().dateByAddingTimeInterval(60*24*3)
        var predicate2 = eventStore.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: nil)
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var endDefaults = defaults.objectForKey("endStrValue") as String!
        var startDefaults = defaults.objectForKey("startStrValue") as String!
        var freeTime = 0
        var time = 0
  //      let userStartTime:Int? = startDefaults.toInt()
    //    let userEndTime:Int? = endDefaults.toInt()
        
        //parse startDefaults
            var parsedStartDef:[String]
            if (startDefaults == nil){
                parsedStartDef = "9:00 AM".componentsSeparatedByString(":")
            }else{
             parsedStartDef = startDefaults.componentsSeparatedByString(":")
            }
                var startDefHour:String = parsedStartDef[0]
            var startDefMinutesAnd12Hour = parsedStartDef[1]
            var startDefMinutesParsed = startDefMinutesAnd12Hour.componentsSeparatedByString(" ")
            var startDefMinutes = startDefMinutesParsed[0]
            var startDefAMPM = startDefMinutesParsed[1]

            let defaultStartHours:Int? = startDefHour.toInt()
            let defaultStartMinute:Int? = startDefMinutes.toInt()
            
        //parse endDefaults
            var parsedStopDef:[String]
            if (startDefaults == nil){
                parsedStopDef = "5:00 PM".componentsSeparatedByString(":")
            }else{
                parsedStopDef = startDefaults.componentsSeparatedByString(":")
            }
            
            var stopDefHour:String = parsedStopDef[0]
            var stopDefMinutesAnd12Hour = parsedStopDef[1]
            var stopDefMinutesParsed = stopDefMinutesAnd12Hour.componentsSeparatedByString(" ")
            var stopDefMinutes = stopDefMinutesParsed[0]
            var stopDefAMPM = stopDefMinutesParsed[1]
            
            let defaultStopHours:Int? = stopDefHour.toInt()
            let defaultStopMinute:Int? = stopDefMinutes.toInt()

            println("hello" + parsedStartDef[0] + parsedStopDef[0])
            println("yes  \(defaultStopHours!)")
            println("no  \(defaultStopMinute!)")
            
            
            
        println("startDate:\(start) endDate:\(endDate)")
        var eV = eventStore.eventsMatchingPredicate(predicate2) as [EKEvent]!
        var theDateFormat = NSDateFormatterStyle.ShortStyle
        formatter.dateStyle = theDateFormat
        var count = 0
        if eV != nil {
            for i in eV {
                
                if i.title == "FitWhen Workout" {
                   println(eV.count)
                    self.array[count] = formatter.stringFromDate(i.startDate)
                    self.arrayEnd[count] = formatter.stringFromDate(i.endDate)
                    count += 1
                    
                    //eventStore.removeEvent(i, span: EKSpanThisEvent, error: nil)
                }
            }
        }
            for date in array{
                println("start")
                println(date)
                
            }
            println("end")
            for date in arrayEnd{
                println("end")
                println(date)
                
            }
        
        
    
}
    

}
