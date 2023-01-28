//
//  GraphView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/19/22.
//

import SwiftUI
import Charts

struct GraphView: View {
    let s : Substance
    var data : [Day] {s.days?.allObjects as! [Day]}
    
    
    @State var shown : Int = 7
    
    
    var body: some View {
        GeometryReader { geometry in
            if (data != []) {
                VStack {
                    Text("History")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.top)
                    VStack {
                        HStack {
                            Text("Cravings")
                                .font(.system(.title2, design: .rounded))
                                .fontWeight(.semibold)
                            Spacer()
                            Picker("", selection: $shown) {
                                Text("7 Days").tag(7)
                                Text("14 Days").tag(14)
                                Text("30 Days").tag(30)
                                Text("6 Months").tag(182)
                                Text("1 Year").tag(365)
                            }.accentColor(Color("TextColor")).background(Color("BodyColor")).cornerRadius(8)
                        }
                        Chart {
                            ForEach(data, id: \.date) { item in
                                if (Calendar.current.inLast(shown, item.date!)) {
                                    BarMark(
                                        x: .value("Date", item.date!, unit: .day),
                                        y: .value("Rating", item.cravingRating)
                                    )
                                    .foregroundStyle(getColor(item.cravingRating))
                                }
                                
                            }
                            
                        }
                        .frame(height: 250)
                        .chartYAxis {
                            AxisMarks(position: .trailing, values: stride(from: 0, through: 10, by: 2).map { $0 })
                        }
                        .chartXAxis {
                            AxisMarks(position: .bottom, values: stride(from: 0, to: shown, by: Int(ceil(Double(shown)/3).rounded(.towardZero))).map {
                                Calendar.current.lastDays(shown)[$0]})
                        }
                    }
                    .padding()
                    .background(Color("MenuColor"))
                    .cornerRadius(16)
                    .padding()
                    .frame(width: geometry.size.width-16)
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                .background(Color("BodyColor"))
            }
            else {
                VStack(alignment: .center) {
                    Spacer()
                    Text("Error: We do not have any data yet")
                    Text("Try submitting today's log!")
                    Spacer()
                }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .background(Color("BodyColor"))
            }
        }
    }
    
    func getColor(_ n: Int16) -> Color {
        switch(n) {
        case 8...Int16.max:
            return Color.red
        case 4...7:
            return Color.yellow
        default:
            return Color.green
        }
    }
}
