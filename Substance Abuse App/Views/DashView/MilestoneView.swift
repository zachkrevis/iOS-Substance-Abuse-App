//
//  MilestoneView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/12/22.
//

import SwiftUI

struct MilestoneView: View {
    let daysSoFar : Int
    let milestone : [ Int : String ]
    var body: some View {
        VStack(alignment: .leading) {
            
            SliderView(value: Double(daysSoFar)/Double(milestone.keys.first!))
            if (milestone.keys.first!-daysSoFar != 0 && milestone.keys.first! != 0) {
                Text("\(milestone.keys.first!-daysSoFar) \({milestone.keys.first!-daysSoFar==1 ? "day" : "days"}()) until next milestone!")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.heavy)
                
                Text(milestone.values.first!)
                    .fontWeight(.bold)
            } else if (milestone.keys.first! == 0) {
                Text("7 days until next milestone!")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.heavy)
                
                Text("1 week")
                    .fontWeight(.bold)
            }
            else {
                Text("Congrats on hitting a milestone!")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.heavy)
                
                Text(milestone.values.first!)
                    .fontWeight(.bold)
            }
        }
        
            .padding()
            .frame(width: abs(UIScreen.main.bounds.width-64))
            .background(Color("MenuColor"))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
    }
}

struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneView(daysSoFar: 34, milestone: [35: "5 Weeks"])
    }
}
