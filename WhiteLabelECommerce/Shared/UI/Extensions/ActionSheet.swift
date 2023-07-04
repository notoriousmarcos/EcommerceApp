//
//  ActionSheet.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation
import SwiftUI

extension ActionSheet {

    static func sortActionSheet(onAction: @escaping ((ProductSort?) -> Void)) -> ActionSheet {
        let byAddedDate: Alert.Button = .default(Text("Sort by added date")) {
            onAction(.byAddedDate)
        }
        let byReleaseDate: Alert.Button = .default(Text("Sort by release date")) {
            onAction(.byReleaseDate)
        }
        let byScore: Alert.Button = .default(Text("Sort by ratings")) {
            onAction(.byScore)
        }
        let byPopularity: Alert.Button = .default(Text("Sort by popularity")) {
            onAction(.byPopularity)
        }

      return ActionSheet(
        title: Text("Sort movies by"),
        message: nil,
        buttons: [
          byAddedDate,
          byReleaseDate,
          byScore,
          byPopularity,
          Alert.Button.cancel({
            onAction(nil)
          })
        ]
      )
    }
}
