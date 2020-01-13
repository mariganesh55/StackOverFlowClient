//
//  DateUtils.swift
//  StackOverFlowClient
//
//  Created by Mariganesh on 03/01/20.
//  Copyright © 2020 Tart Labs. All rights reserved.
//

import Foundation
import SwiftMoment
import DatePickerDialog

class DateUtils {
    private static let acceptedDateFormats = [
        "yyyy-MM-dd",
        "EEE, dd MMM yyyy HH:mm:ss Z",
        "EEE MMM dd HH:mm:ss yyyy",
        "yyyy-MM-dd HH:mm:ss",
        "yyyy-MM-dd HH:mm:ss Z",
        "yyyy-MM-dd'T'HH:mm:ssZ",
        "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
        "yyyy-MM-dd'T'HH:mm:ss'Z'",
        "yyyy-MM-dd'T'HH:mm:ss Z",
        "dd MMM yyyy",
        "MM/dd/yyyy",
        "HH:mm",
        "h:mm a"
    ]
    
    
    public static func parseDate(string:String!) -> Date! {
        if string == nil || string == "" {
            return nil
        }
        
        for pattern in acceptedDateFormats {
            if let date = moment(string, dateFormat: pattern, timeZone: TimeZone(abbreviation: "UTC")!, locale: Locale.current){
                return date.date
            }
        }
        return nil
    }
    
    public static func toString(date:Date!, format:String = "dd MMM yyyy") -> String{
        guard let date = date else{
            return ""
        }
        return moment(date).format(format)
    }
    
    public static func toMinutesAndSeconds(date:Date!, format:String = "h:mm a") -> String{
        guard let date = date else{
            return ""
        }
        return moment(date).format(format)
    }
    
    public static func toHumanDateString(date:Date) -> String {
        return moment(date).fromNow()
    }
    
    public static func showDatePicker(title:String,
                                      defaultDate:Date? = Date(),
                                      datePickerMode: UIDatePicker.Mode =  .date,
                                      maximumDate:Date?,
                                      minimumDate:Date?,
                                      closure:@escaping (Date?)->()){
        
        let customFont = Utils.getFont(named: Fonts.GoogleSansMedium, fontSize: UIFont.labelFontSize)
        DatePickerDialog.init(textColor: UIColor.black, buttonColor: Constants.getThemeDarkColor, font: customFont, locale: nil, showCancelButton: true)
            .show(title, doneButtonTitle: "Done",
                  cancelButtonTitle: "Cancel",
                  defaultDate:defaultDate ?? Date(),
                  minimumDate: minimumDate,
                  maximumDate: maximumDate,
                  datePickerMode: .date) { (date) -> Void in
                    // call closure
                    closure(date)
        }
    }
    
    public static func diffInDays(day1:Date, day2:Date) -> Int{
        let interval = day1.timeIntervalSince(day2)
        return Int(round(interval / 86400))
    }
    
    public static func addDays(currentDate:Date = Date(),numberOfDays:Int) -> Date {
        let currentDateMoment = moment(currentDate)
        let numberOfDateMoment = currentDateMoment.add(numberOfDays, TimeUnit.Days)
        return numberOfDateMoment.date
    }
    
    public static func isSameDate(date1:Date!, date2: Date!) -> Bool{
        if date1 == nil || date2 == nil {
            return false
        }
        let moment1 = moment(date1)
        let moment2 = moment(date2)
        if moment1.format("DD-MM-YYYY") == moment2.format("DD-MM-YYYY"){
            return true
        }
        return false
    }
    
    public static func differenceFromToday(date:Date!) -> String{
        
        let today = Date()
        if self.isSameDate(date1: date, date2: today) {
            return "Today"
        }else if DateUtils.diffInDays(day1: today, day2: date) == 1 {
            return "Yesterday"
        }else {
            return DateUtils.toString(date: date)
        }
    }
    
    public static func messageDate(date:Date!) -> String{
        
        guard let date = date else{
            return ""
        }
        
        let timeString = DateUtils.toMinutesAndSeconds(date: date)
        let dayString = DateUtils.differenceFromToday(date: date)
        
        if dayString == "Today"{
            return "\(timeString)"
        }else if dayString == "Yesterday"{
            return "Yesterday"
        }else {
            return "\(DateUtils.toString(date: date, format: "MMM, dd"))"
        }
    }
}

