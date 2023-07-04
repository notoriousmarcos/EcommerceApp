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
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
