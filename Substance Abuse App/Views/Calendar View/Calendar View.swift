//
//  Calendar View.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/20/22.
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var manager : SubstanceManager
    @State var shown : Date = Calendar.current.startOfDay(for: Date())
    
    let s : Substance;
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Color("BodyColor").ignoresSafeArea()
                ScrollView(.vertical) {
                    VStack {
                        CustomDatePicker(s: s, selected: $shown)
                        Spacer()
                        VStack(spacing: 18) {
                            Spacer()
                            Text(shown, style: .date)
                                .font(.title2.bold())
                                .multilineTextAlignment(.center)
                            let day = manager.getDay(s, date: shown)
                            if (day != nil) {
                                Text("Craving rating: \(day!.cravingRating)")
                                    .font(.title3.bold())
                                    .multilineTextAlignment(.center)
                                Text("Notes:")
                                    .font(.title3.bold())
                                    .multilineTextAlignment(.center)
                                Text(day!.notes!)
                            }
                            else {
                                Text("I'm sorry, but we have no data on this date.")
                                    .font(.title3.bold())
                                    .multilineTextAlignment(.center)
                            }
                            Spacer()
                        }.padding()
                    }
                }
            }
        }
    }
}
