//
//  TheMovieDBApp.swift
//  TheMovieDB
//
//  Created by Eduardo Geovanni Pérez Munguía on 21/05/24.
//

import SwiftUI

@main
struct TheMovieDBApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
