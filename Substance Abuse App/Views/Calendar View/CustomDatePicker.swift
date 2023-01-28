//
//  CustoMDatePicker.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 1/14/23.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @EnvironmentObject var manager : SubstanceManager
    
    let days : [String] = ["Sun","Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"]
    
    @State var currentMonth : Int = 0
    
    let s : Substance
    
    @Binding var selected : Date
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(FormatMonth()[0])
                        .font(.caption)
                    Text(FormatMonth()[1])
                        .font(.title.bold())
                }
                Spacer()
                
                Button(action: {
                    self.currentMonth -= 1
                }) {
                    Image(systemName: "chevron.left")
                }
                .font(.title2)
                Button(action: {
                    
                        self.currentMonth += 1
                }) {
                    Image(systemName: "chevron.right")
                }
                .font(.title2)
            }
            .padding()
            
            HStack {
                ForEach(days, id: \.self) { day in
                    Text(day)
                }
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(ExtractDate()) {value in
                    if (value.day != -1) {
                        Button(action: {selected = value.date}) {
                            Circle()
                                .fill(getColor(date: value.date, days: manager.daysInRange(s, week: GetMonth().getMonth())))
                                .frame(width: 32, height: 32)
                                .overlay {
                                    Text("\(value.day)")
                                        .foregroundColor(.black)
                                        .fontDesign(.rounded)
                                        .fontWeight(selected == value.date ? .heavy : .regular)
                                }
                        }
                    } else {
                        Text("")
                    }
                }
            }
            Spacer()
            
        }
    }
    
    func getColor(date: Date, days: [Day]) -> Color {
        if let day = days.first(where: {$0.date == date}) {
            switch(day.cravingRating) {
            case 8...Int16.max:
                return Color.red
            case 4...7:
                return Color.yellow
            default:
                return Color.green
            }
        }
        else {
            return Color.white
        }
    }
    
    func FormatMonth() -> [String] {
        let Formatter = DateFormatter()
        Formatter.dateFormat = "YYYY MMMM"
        
        let date = Formatter.string(from: GetMonth())
        
        return date.components(separatedBy: " ")
    }
    
    func GetMonth() -> Date {
        guard let currentMonth = Calendar.current.date(byAdding: .month, value: self.currentMonth, to: Date().startOfMonth())
        else {
            return Date()
        }
        
        return currentMonth
    }
    
    func ExtractDate() -> [DateValue] {
        guard let currentMonth = Calendar.current.date(byAdding: .month, value: self.currentMonth, to: Date().startOfMonth())
        else {
            return []
        }
        
        var days = currentMonth.getMonth().compactMap { date -> DateValue in
            let day = Calendar.current.component(.day, from: date)
            return DateValue(date: date, day: day)
        }
        
        let firstWeekDay = Calendar.current.component(.weekday, from: days.first!.date)
        
        for _ in 0..<firstWeekDay-1 {
            days.insert(DateValue(date: Date(), day: -1), at: 0)
        }
        
        return days
    }
}


extension Date {
    func getMonth() -> [Date] {
        let range = Calendar.current.range(of: .day, in: .month, for: self)!
        
        return range.compactMap {day -> Date in
            return Calendar.current.date(byAdding: .day, value: day-1, to: self)!
        }
    }
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
