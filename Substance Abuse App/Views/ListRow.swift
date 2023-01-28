//
//  ListRow.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/17/22.
//

import SwiftUI

struct ListRow: View {
    let s : Substance
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text(s.name ?? "No Name")
                Text(String(Calendar.current.daysSince(s.dateStarted!)))
                Text(String(s.price))
            }
                .foregroundColor(Color("TextColor"))
                .frame(width: geometry.size.width, height: 64)
                .background(Color("MenuColor"))
            
        }
    }
}

