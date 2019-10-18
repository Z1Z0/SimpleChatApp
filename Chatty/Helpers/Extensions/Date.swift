//
//  Date.swift
//  Chatty
//
//  Created by Ahmed Abd Elaziz on 10/14/19.
//  Copyright © 2019 Ahmed Abd Elaziz. All rights reserved.
//

import Foundation

extension Date {
    
    var toString : String {
        get{
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: self)
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "yyyy-MM-dd"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)
            return myStringafd
        }
    }
    
    var toFormatedString : String {
        
        get{
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: self)
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)
            return myStringafd
        }
    }
    
    var toTimestampString : String {
        get{
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: self)
            return myString
        }
    }
    
    var timeString : String {
        get{
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.timeStyle = .short
            let myString = formatter.string(from: self)
            return myString
        }
    }
    
    var timeAgoDisplay : String {

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC") ?? TimeZone.current
        let date = calendar.date(byAdding: .hour, value: 2, to: self)!

        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        
        if minuteAgo < date {
            let diff = Calendar.current.dateComponents([.second], from: date, to: Date()).second ?? 0
            return "\(diff) sec ago"
        } else if hourAgo < date {
            let diff = Calendar.current.dateComponents([.minute], from: date, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < date {
            let diff = Calendar.current.dateComponents([.hour], from: date, to: Date()).hour ?? 0
            return "\(diff) hrs ago"
        } else if weekAgo < date {
            let diff = Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
            return "\(diff) days ago"
        }
        let diff = Calendar.current.dateComponents([.weekOfYear], from: date, to: Date()).weekOfYear ?? 0
        return "\(diff) weeks ago"
    }
}
