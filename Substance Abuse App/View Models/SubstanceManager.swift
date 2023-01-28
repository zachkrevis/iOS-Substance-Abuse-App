//
//  SubstanceModel.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/16/22.
//

import Foundation
import CoreData
import NotificationCenter

class SubstanceManager : ObservableObject {
    let container : NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Recovery")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    func NewSubstance(_ name:String, _ price:Double, _ howOften:Int16, context:NSManagedObjectContext) {
        let newSubstance = Substance(context: context)
        newSubstance.name = name
        newSubstance.dateStarted = Calendar.current.startOfDay(for: Date())
        newSubstance.lastUsed = Calendar.current.startOfDay(for: Date())
        newSubstance.price = price
        newSubstance.daysBetweenPurchases = howOften
        try? context.save()
    }
    
    func getDate(_ substance:Substance) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        return (dateFormatter.string(from: Calendar.current.startOfDay(for: substance.dateStarted!)))
    }
    
    func getSaved(_ s: Substance) -> Double {
        let days = Calendar.current.daysSince(s.dateStarted!)
        let returnVar = Double(days)*s.price / Double(s.daysBetweenPurchases)
        return returnVar
        
    }
    
    
    func addDate(_ s: Substance, rating: Int16, notes: String, date : Date, context: NSManagedObjectContext) {
        for day in s.days! {
            if ((day as! Day).date! == date) {
                s.removeFromDays(day as! Day)
                break
            }
        }
        
        let newDay = Day(context: context)
        newDay.date = date
        newDay.cravingRating = rating
        newDay.notes = notes
        
        s.addToDays(newDay)
        try? context.save()
    }
    
    func daysInRange(_ s: Substance, week: [Date]) -> [Day] {
        var days : [Day] = []
        for day in s.days! {
            if (week.contains((day as! Day).date!)) {
                days.append((day as! Day))
            }
        }
        
        return days
        
    }
    
    func getMilestone(days: Int, startDate: Date) -> [Int : String] {
        if (0...21 ~= days) {
            let milestone : String = "\(Int(ceil(Double(days)/7))) Week\(Int(ceil(Double(days)/7)) != 1 ? "s" : "")"
            return [(Int(ceil(Double(days)/7)*7)) : milestone]
        }
        else {
            let in6Months = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .month, value: 6, to: startDate)!)
            let daysBetween = Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: startDate), to: Calendar.current.startOfDay(for: in6Months)).day
            
            if (22...daysBetween! ~= days) {
                let monthsBetween = Calendar.current.dateComponents([.month], from: Calendar.current.startOfDay(for: startDate), to: Calendar.current.startOfDay(for: Date())).month!
                
                let milestone : String = "\(monthsBetween+1) Month\(monthsBetween+1 != 1 ? "s" : "")"
                
                
                let inXMonths = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .month, value: monthsBetween+1, to: startDate)!)
                
                let daysBetween = Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: startDate), to: Calendar.current.startOfDay(for: inXMonths)).day
                
                return [daysBetween! : milestone]

            }
            else {
                
                let yearsBetween = Calendar.current.dateComponents([.year], from: Calendar.current.startOfDay(for: startDate), to: Calendar.current.startOfDay(for: Date())).year!
                
                let milestone : String = "\(yearsBetween+1) Year\(yearsBetween+1 != 1 ? "s" : "")"
                
                let inXYears = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .year, value: yearsBetween+1, to: startDate)!)
                
                let daysBetween = Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: startDate), to: Calendar.current.startOfDay(for: inXYears)).day
                
                return [daysBetween! : milestone]
            }
        }
    }
    
    func getDay(_ s: Substance, date : Date) -> Day? {
        guard let day = ((s.days!.allObjects) as! [Day]).first(where: {Calendar.current.startOfDay(for: $0.date!) == Calendar.current.startOfDay(for: date)}) else {
            return nil
        }
        return day
    }
}
