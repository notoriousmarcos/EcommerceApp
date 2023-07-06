//
//  SearchField.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 03/07/23.
//

import Combine
import SwiftUI

struct SearchField: View {
  @ObservedObject var viewModel: SearchTextViewModel
  @Binding var isSearching: Bool
  @FocusState private var focused: Bool

  let placeholder: String
  var dismissButtonTitle: String
  var dismissButtonCallback: (() -> Void)?

  private var searchCancellable: Cancellable?

  init(
    viewModel: SearchTextViewModel,
    placeholder: String,
    isSearching: Binding<Bool>,
    dismissButtonTitle: String = "Cancel",
    dismissButtonCallback: (() -> Void)? = nil
  ) {
    self.viewModel = viewModel
    self.placeholder = placeholder
    self._isSearching = isSearching
    self.dismissButtonTitle = dismissButtonTitle
    self.dismissButtonCallback = dismissButtonCallback

    self.searchCancellable = viewModel.searchSubject.sink(receiveValue: { value in
      isSearching.wrappedValue = !value.isEmpty
    })
  }

  var body: some View {
    GeometryReader { _ in
      HStack(alignment: .center, spacing: 0) {
        Image(systemName: "magnifyingglass")

        TextField(
          self.placeholder,
          text: self.$viewModel.searchText
        )
        .focused($focused)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal)

        if !self.viewModel.searchText.isEmpty {
          Button(
            action: {
              self.viewModel.searchText = ""
              self.isSearching = false
              self.dismissButtonCallback?()
            },
            label: {
              Text(self.dismissButtonTitle).foregroundColor(.pink)
            }
          )
          .buttonStyle(BorderlessButtonStyle())
          .animation(.easeInOut, value: 1)
        }
      }
      .padding(4)
    }
    .frame(height: 44)
  }
}

#if DEBUG
struct SearchField_Previews: PreviewProvider {
  static var previews: some View {
    let withText = SearchTextViewModel()
    withText.searchText = "Test"

    return VStack {
      SearchField(viewModel: SearchTextViewModel(),
                  placeholder: "Search anything",
                  isSearching: .constant(false))
      SearchField(viewModel: withText,
                  placeholder: "Search anything",
                  isSearching: .constant(false))

      List {
        SearchField(viewModel: withText,
                    placeholder: "Search anything",
                    isSearching: .constant(false))
        Section(header: SearchField(viewModel: withText,
                                    placeholder: "Search anything",
                                    isSearching: .constant(false))) {
          SearchField(viewModel: withText,
                      placeholder: "Search anything",
                      isSearching: .constant(false))
        }
      }

      List {
        SearchField(viewModel: withText,
                    placeholder: "Search anything",
                    isSearching: .constant(false))
        Section(header: SearchField(viewModel: withText,
                                    placeholder: "Search anything",
                                    isSearching: .constant(false))) {
          SearchField(viewModel: withText,
                      placeholder: "Search anything",
                      isSearching: .constant(false))
        }
      }
    }
  }
}
#endif
