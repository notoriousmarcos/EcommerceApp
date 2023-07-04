//
//  WhiteLabelECommerceApp.swift
//  Shared
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

@main
struct WhiteLabelECommerceApp: App {

  let main = Main.shared

  var body: some Scene {
    WindowGroup {
      HomeView()
        .environmentObject(main)
    }
  }
}
