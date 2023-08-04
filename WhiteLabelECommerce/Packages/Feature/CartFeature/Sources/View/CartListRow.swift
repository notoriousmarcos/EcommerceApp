//
//  SwiftUIView.swift
//  
//
//  Created by Marcos Vinicius Brito on 04/08/23.
//

import Mock
import NotoriousComponentsKit
import SwiftUI

struct CartListRow: View {
  @Binding var item: CartItemData
  var minusAction: ((CartItemData) -> Void)?
  var plusAction: ((CartItemData) -> Void)?

  var body: some View {
    HStack(alignment: .center, spacing: 16) {
      if let imageURL = item.product.imagesURL.first, let url = URL(string: imageURL) {
        PrettyImage(url: url)
          .frame(width: 80, height: 80)
          .cornerRadius(12)
      }

      VStack(alignment: .leading, spacing: 8) {
        Text(item.product.title)
          .font(.title3)
          .fontWeight(.medium)
          .foregroundColor(.primary)

        HStack {
          Text(item.product.price.toCurrencyFormat())
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.secondary)

          Spacer(minLength: 16)

          Button {
            minusAction?(item)
          } label: {
            Image(systemName: item.quantity > 1 ? "minus" : "trash")
              .foregroundColor(.primaryColor)
          }
          .buttonStyle(.borderless)

          Text("\(item.quantity)")
            .frame(minWidth: 30)

          Button {
            plusAction?(item)
          } label: {
            Image(systemName: "plus")
              .foregroundColor(.primaryColor)
          }
          .buttonStyle(.borderless)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(maxWidth: .infinity)
  }
}

struct CartListRow_Previews: PreviewProvider {
  static var item = CartItemData(product: Mocks.product, quantity: 1)
  static var previews: some View {
    Group {
      CartListRow(
        item: .constant(item),
        minusAction: { _ in
          item.quantity -= 1
          print("finded \(item.quantity)")
        },
        plusAction: { _ in
          item.quantity += 1
          print("finded \(item.quantity)")
        }
      )
      CartListRow(
        item: .constant(item),
        minusAction: { _ in
          item.quantity -= 1
          print("finded \(item.quantity)")
        },
        plusAction: { _ in
          item.quantity += 1
          print("finded \(item.quantity)")
        }
      )
      .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
      CartListRow(
        item: .constant(item),
        minusAction: { _ in
          item.quantity -= 1
          print("finded \(item.quantity)")
        },
        plusAction: { _ in
          item.quantity += 1
          print("finded \(item.quantity)")
        }
      )
      .preferredColorScheme(.dark)
    }
  }
}
