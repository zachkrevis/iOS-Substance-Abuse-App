//
//  ContentView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/12/22.
//

import SwiftUI

struct DashView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var manager : SubstanceManager
    
    let s : Substance;
    
    
    let Price:Double
    let howOften:Int16
    
    
    var Days:Int {
        (Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: s.lastUsed!), to: Calendar.current.startOfDay(for: Date())).day!)
    }
    
    var saved :Double {
        Double(Days)*Price / Double(howOften) - Price*Double(s.timesUsed)
    }
    
    var data : [Day] {(s.days?.allObjects as! [Day]).sorted(by: {$0.date! < $1.date!})}
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                Color("BodyColor").ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        DaysInRecoverView(days: (Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: s.lastUsed!), to: Calendar.current.startOfDay(for: Date())).day!), s: s)
                        
                        SavedView(saved: saved)
                            .padding(.vertical, 5)
                        MilestoneView(daysSoFar: Days, milestone: manager.getMilestone(days: Days, startDate: s.dateStarted!))
                            .padding(.vertical, 5)
                        WeekView(s: s)
                            .padding(.vertical, 5)
                        Spacer()
                    }.padding()
                }
            }
            .frame(width: geometry.size.width, height: abs(geometry.size.height-48))
            .overlay(alignment: .topLeading) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 34, height: 28)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color("TextColor"))
                        .padding()
                        .offset(x: 12, y: 8)
                }
            }
        }
    }
}
