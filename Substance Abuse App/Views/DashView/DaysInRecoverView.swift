//
//  DaysInRecoverView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/12/22.
//

import SwiftUI

struct DaysInRecoverView: View {
    let days : Int
    let s : Substance
    var body: some View {
        VStack {
            Text("You haven't used \(s.name!.lowercased()) for...")
            Circle()
                .strokeBorder(Color("AccentColor"), lineWidth: 11)
                .frame(width: 197, height: 197)
                .overlay {
                    VStack {
                        Text("\(days)")
                        Text("Days")
                        }
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("AccentColor"))
                }
            
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                .shadow(color: Color.accentColor.opacity(0.3), radius: 20, x: 0, y: 10)
            Text("Keep it up!")
        }
            .font(.system(.title2, design: .rounded))
            .fontWeight(.heavy)
            .frame(width: 250)
            .multilineTextAlignment(.center)
    }
}

