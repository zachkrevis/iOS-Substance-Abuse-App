//
//  MenuView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/12/22.
//

import SwiftUI

struct SavedView: View {
    let saved : Double
    var body: some View {
        VStack(alignment: .leading) {
            SliderView(value: saved.truncatingRemainder(dividingBy: 1))
            Text("$\(saved, specifier: "%.2f") saved!")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.heavy)
        }
            .padding()
            .frame(width: abs(UIScreen.main.bounds.width-64))
            .background(Color("MenuColor"))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView(saved: 34.60)
    }
}
