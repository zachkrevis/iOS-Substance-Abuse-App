//
//  Substance_Abuse_AppApp.swift
//  Substance Abuse App
//
//  Created by Zach Krevis on 11/12/22.
//

import SwiftUI

@main
struct Substance_Abuse_AppApp: App {
    @StateObject private var manager = SubstanceManager()
    
    var body: some Scene {
        WindowGroup {
            SubstanceListView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
