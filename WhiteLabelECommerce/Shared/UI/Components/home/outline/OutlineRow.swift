//
//  OutlineRow.swift
//  MovieSwift
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
                    .foregroundColor(isSelected ? .steam_gold : .primary)
            }
            .frame(width: 40)
            Text(item.title)
                .font(.FjallaOne(size: 24))
                .foregroundColor(isSelected ? .steam_gold : .primary)
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
        OutlineRow(item: .popular, selectedMenu: .constant(.popular))
    }
}
#endif
