//
//  WeekView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/14/22.
//

import SwiftUI

struct WeekView: View {
    @EnvironmentObject var manager : SubstanceManager
    
    let s : Substance;
    
    let week : [Date] = Calendar.current.getWeek()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                ForEach(week, id: \.self) {date in
                    let color : Color = getColor(date: date, days: manager.daysInRange(s, week: week))
                    Circle()
                        .fill(color)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                    
                }
            }
            Text("This week's craving levels")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.heavy)
            
        }
        .padding()
        .frame(width: abs(UIScreen.main.bounds.width-64))
        .background(Color("MenuColor"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
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
}
