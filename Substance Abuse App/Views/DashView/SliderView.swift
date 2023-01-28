//
//  SliderView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/12/22.
//

import SwiftUI

struct SliderView: View {
    var value : Double;
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading)
            {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color("DarkAccent"))
                        .frame(width: geometry.size.width, height: 25)
                
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                        .overlay(alignment: .leading){
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.accentColor)
                                .frame(width: {value < 0.1 ? CGFloat(0.1*geometry.size.width) : CGFloat(geometry.size.width * value )}(),height: 25)
                                .shadow(color: Color.accentColor.opacity(0.4), radius: 20, x: 0, y: 10)
                        }
                
            }
        }   .frame(height:25)
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: 0.01)
    }
}
