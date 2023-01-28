//
//  SubstanceView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/19/22.
//

import SwiftUI

enum CurrentPage {
    case dash
    case graph
    case addDay
    case calendar
    case saved
}


struct SubstanceView: View {
    @Environment(\.managedObjectContext) var context
    
    @EnvironmentObject var manager : SubstanceManager
    
    let s : Substance;
    
    
    @State var currentPage = CurrentPage.dash
    
    var body: some View {
        
        GeometryReader {geometry in
            ZStack {
                switch (currentPage) {
                case .dash:
                    DashView(s: s, Price: s.price, howOften: s.daysBetweenPurchases)
                case .saved:
                    SavingView(s: s)
                case .addDay:
                    AddDayView(s: s, currentPage: $currentPage)
                case .graph:
                    GraphView(s: s)
                case .calendar:
                    CalendarView(s: s)
                }
            }
            .overlay(alignment: .bottom) {
                HStack {
                    Button(action: {currentPage = CurrentPage.dash}) {
                        Image(systemName: "house.fill")
                            .foregroundColor(Color("TextColor"))
                            .font(.title)
                    }
                    .padding()
                    Button(action: {currentPage = CurrentPage.graph}) {
                        Image(systemName: "chart.xyaxis.line")
                            .foregroundColor(Color("TextColor"))
                            .font(.title)
                    }
                    .padding()
                    
                    Button(action: {
                        if (currentPage != CurrentPage.addDay) {
                            currentPage = CurrentPage.addDay
                        } else {
                            currentPage = CurrentPage.dash
                        }
                        
                    }) {
                        Circle()
                            .fill(Color.accentColor)
                            .overlay {
                                Image(systemName: "plus")
                                    .rotationEffect(Angle(degrees: currentPage == CurrentPage.addDay ? 45 : 0))
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(width: 48, height: 48)
                            }
                    }
                    .offset(y: -24)
                    
                    Button(action: {currentPage = CurrentPage.calendar}) {
                        Image(systemName: "calendar")
                            .foregroundColor(Color("TextColor"))
                            .font(.title)
                    }
                    .padding()
                    Button(action: {currentPage = CurrentPage.saved}) {
                        Image(systemName: "dollarsign")
                            .foregroundColor(Color("TextColor"))
                            .font(.title)
                    }
                    .padding()
                    
                }
                
                .frame(width: geometry.size.width, height: 48)
                .background(Color("MenuColor"))
            }
        }
            .navigationBarBackButtonHidden(true)
    }
}
