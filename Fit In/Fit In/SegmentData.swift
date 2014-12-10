//
//  SegmentData.swift
//  Fit In
//
//  Created by Jason Robinson on 11/24/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit
import EventKit

class SegmentData: NSObject {
   
    
    var eventStore = EKEventStore()
    //work options
    var gym: [String] = ["Easy - 15 squats","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var home: [String] = ["Easy - 15 squats","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    var office: [String] = ["Easy - 15 squats","Easy - Run up and down stairs for 2 minutes","Easy - 15 push-ups","Easy - 15 sit ups","Easy - 2 minutes of wall sits","Medium - 30 squats","Medium - 30 push-ups","Medium - 30 sit ups","Medium - Run up and down stairs for 5 minutes","Medium - 5 minutes of wall sits","Hard - 45 squats","Hard - 45 push-ups","Hard - 45 sit ups","Hard - 10 minutes of wall sits","Hard -  Run up and down stairs for 10 minutes"]
    
   
    //workout selection from workoutSelectionViewController
    var dataFromWorkout:String = "Workout"
    //time of day from workoutSelectionViewController
    var workoutTime:String = "Select"
    //length of workout from workoutSelectionViewController
    var workoutLength = ""
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
    
    //minimum workout time in WorkoutTimeController
    var minWorkoutTime = 0
    
    
    
    func addEvent(){
        
        
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
        comp.hour = hours!
        
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
        if !ok {
            println("save simple event \(err!.localizedDescription)")
            return
        }
        println("no errors")
    }
    
    
    func calendarWithName( name:String ) -> EKCalendar? {
        let calendars = self.eventStore.calendarsForEntityType(EKEntityTypeEvent) as [EKCalendar]
        
        
        for cal in calendars { // (should be using identifier)
            if cal.title == name {
                
                return cal
            }
        }
        println ("failed to find calendar")
        return nil
    }
    
    func createRecurringEvent () {
        
        
        let cal : EKCalendar! = self.calendarWithName("Calendar")
        if cal == nil {
            return
        }
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitDay | .WeekdayOrdinalCalendarUnit, fromDate: date)
        let month = components.month
        let day = components.day
        let year = components.year
        let dayOrdinal = components.weekdayOrdinal + 1
        println(dayOrdinal)
        
        
        let everyDay = EKRecurrenceDayOfWeek(2)
        let reminderMonth = month
        let recur = EKRecurrenceRule(
            recurrenceWithFrequency:EKRecurrenceFrequencyDaily, // every year
            interval:1, // no, every *two* years
            daysOfTheWeek:nil,
            daysOfTheMonth:nil,
            monthsOfTheYear:nil,
            weeksOfTheYear:nil,
            daysOfTheYear:nil,
            setPositions: nil,
            end:nil)
        
        let ev = EKEvent(eventStore:self.eventStore)
        ev.title = "Mysterious biennial Sunday-in-January morning ritual"
        ev.addRecurrenceRule(recur)
        ev.calendar = cal
        // need a start date and end date
        let greg = NSCalendar(calendarIdentifier:NSCalendarIdentifierGregorian)!
        let comp = NSDateComponents()
        comp.year = year
        comp.month = reminderMonth
        
        comp.weekday = 3
        comp.weekdayOrdinal = 5
        comp.hour = 10
        ev.startDate = greg.dateFromComponents(comp)
        comp.hour = 11
        ev.endDate = greg.dateFromComponents(comp)
        
        var err : NSError?
        let ok = self.eventStore.saveEvent(ev, span:EKSpanFutureEvents, commit:true, error:&err)
        if !ok {
            println("save recurring event \(err!.localizedDescription)")
            return
        }
        println("no errors")
    }
    
}



