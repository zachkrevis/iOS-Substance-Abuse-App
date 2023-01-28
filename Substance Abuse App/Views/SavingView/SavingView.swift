//
//  SalesView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/20/22.
//

import SwiftUI

struct SavingView: View {
    let s: Substance
    
    
    var saved :Double {
        Double(Calendar.current.daysSince(s.dateStarted!))*s.price / Double(s.daysBetweenPurchases)
    }
    
    var proj_saved :Double {
        Double(Calendar.current.daysSince(s.dateStarted!) + shown)*s.price / Double(s.daysBetweenPurchases)
    }
    
    @State var shown : Int = 14
    
    var body: some View {
        GeometryReader {geometry in
            VStack {
                Text("Savings").font(.title).fontWeight(.heavy)
                
                SavedView(saved: saved)
                    .padding(.vertical, 5)
                
                VStack {
                    HStack{
                        Text("Price")
                        Spacer()
                        Text("\(s.price, specifier: "%.2f")")
                            .foregroundColor(.accentColor)
                    }
                    HStack{
                        Text("Purchases per week")
                        Spacer()
                        Text("\(s.daysBetweenPurchases/7)")
                            .foregroundColor(.accentColor)
                    }
                    HStack{
                        Text("Calculated daily expenses")
                        Spacer()
                        Text("\(s.price/Double(s.daysBetweenPurchases), specifier: "%.2f")")
                            .foregroundColor(.accentColor)
                    }
                }
                .fontWeight(.bold)
                .padding()
                .frame(width:UIScreen.main.bounds.width-64)
                .background(Color("MenuColor"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                .padding(4)
                
                
                HStack {
                    VStack(alignment: .leading) {
                        Picker("", selection: $shown) {
                            Text("14 Days").tag(14)
                            Text("30 Days").tag(30)
                            Text("6 Months").tag(182)
                            Text("1 Year").tag(364)
                        }.accentColor(Color("TextColor")).background(Color("BodyColor")).cornerRadius(8)
                        
                        Text("Projected Savings:")
                            .font(.title3)
                            .fontWeight(.heavy)
                        Text("$\(proj_saved, specifier: "%.2f")")
                            .foregroundColor(.accentColor)
                            .font(.title2)
                            .fontWeight(.heavy)
                    }
                    Spacer()
                }
                .padding()
                .fontWeight(.bold)
                .frame(width:UIScreen.main.bounds.width-64)
                .background(Color("MenuColor"))
                .cornerRadius(16)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                .padding(4)
                
                Spacer()
            }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color("BodyColor"))
        }
    }
}
