//
//  WhiteLabelECommerceApp.swift
//  Shared
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

@main
struct WhiteLabelECommerceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
