//
//  DiamondsApp.swift
//  Diamonds
//
//  Created by Kevin Kirkland on 7/13/23.
//testing

import SwiftUI

@main
struct DiamondsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
