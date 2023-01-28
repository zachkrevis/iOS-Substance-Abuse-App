//
//  CalendarView.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/20/22.
//

import SwiftUI

struct CalendarView: View {
    
    @State var selected : Date = Calendar.current.startOfDay(for: Date())
    var body: some View {
        GeometryReader { geometry in
            VStack {
                UICalendarView()
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
