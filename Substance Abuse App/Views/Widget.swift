//
//  Widget.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 12/11/22.
//

import SwiftUI
import WidgetKit

struct WidgetView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct MainWidget : Widget {
    var body : some WidgetConfiguration {
        
        WidgetView()
        .description("Test")
        .configurationDisplayName(Text("Test"))
        .supportedFamilies([.systemSmall])
    }
}
struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
