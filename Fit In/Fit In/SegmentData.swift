//
//  SegmentData.swift
//  Fit In
//
//  Created by Jason Robinson on 11/24/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class SegmentData: NSObject {
   
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
}
