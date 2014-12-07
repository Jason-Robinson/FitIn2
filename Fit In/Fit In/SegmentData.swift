//
//  SegmentData.swift
//  Fit In
//
//  Created by Jason Robinson on 11/24/14.
//  Copyright (c) 2014 Lexus LLC. All rights reserved.
//

import UIKit

class SegmentData: NSObject {
   
    var gym: [String] = ["gym1",  "gym"]
    var home: [String] = ["home", "home1"]
    var office: [String] = ["office", "office1"]
    
    var dataFromWorkout:String = "Workout"
    var workoutLength:String = ""
    var workoutTime:String = "Select"
    
    var workoutTimingStart = "9:00 AM"
    var workoutTimingEnd = "5:00 PM"
    
    var dailyReminderTime = "8:00 AM"
    
    var minWorkoutTime = 0
}
