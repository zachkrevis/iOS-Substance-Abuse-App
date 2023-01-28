//
//  Calendar+DaysBetween.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/17/22.
//

import Foundation

extension Calendar {
    func daysSince(_ date:Date) -> Int {
        let today = Date()
        let diffInDays = Calendar.current.dateComponents([.day], from: startOfDay(for: date), to: startOfDay(for: today)).day
        return diffInDays ?? 0
    }
    
    
    
    func getWeek() -> [Date] {
        let startOfWeek = Calendar.current.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: Date()).date!
        var week : [Date] = []
        week.append(startOfWeek)
        
        var temp = startOfWeek
        for _ in 1..<7 {
            temp = Calendar.current.date(byAdding: .day, value: 1, to: temp)!
            week.append(temp)
        }
        
        return week
    }

    func lastDays(_ num: Int) -> [Date] {
        let today = startOfDay(for:Date())
        var lastDays : [Date] = []
        lastDays.append(today)
        
        
        var temp = today
        for _ in 1..<num {
            temp = Calendar.current.date(byAdding: .day, value: -1, to: temp)!
            lastDays.append(temp)
        }
        
        return lastDays.sorted{$0 < $1}
    }
    
    func inLast(_ num:Int, _ date:Date)->Bool {
        let lastDays = lastDays(num)
        return lastDays.contains(date)
    }
    

}
