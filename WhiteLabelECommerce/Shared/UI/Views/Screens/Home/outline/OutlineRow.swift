//
//  OutlineRow.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import SwiftUI

struct OutlineRow: View {
  let item: OutlineMenu
  @Binding var selectedMenu: OutlineMenu

  var isSelected: Bool {
    selectedMenu == item
  }

  var body: some View {
    HStack {
      Group {
        Image(systemName: item.image)
          .imageScale(.large)
          .foregroundColor(isSelected ? .steamGold : .primary)
      }
      .frame(width: 40)
      Text(item.title)
        .font(.fjallaOne(size: 24))
        .foregroundColor(isSelected ? .steamGold : .primary)
    }
    .padding()
    .onTapGesture {
      self.selectedMenu = self.item
    }
  }
}

#if DEBUG
struct OutlineRow_Previews: PreviewProvider {
  static var previews: some View {
    OutlineRow(item: .products, selectedMenu: .constant(.products))
  }
}
#endif
