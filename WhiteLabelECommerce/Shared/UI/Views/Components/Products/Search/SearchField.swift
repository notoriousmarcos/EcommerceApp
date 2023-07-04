//
//  SearchField.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 03/07/23.
//

import SwiftUI
import Combine

struct SearchField : View {
  @ObservedObject var searchTextWrapper: SearchTextObservable
  @Binding var isSearching: Bool
  let placeholder: String
  var dismissButtonTitle: String
  var dismissButtonCallback: (() -> Void)?

  private var searchCancellable: Cancellable? = nil

  init(
    searchTextWrapper: SearchTextObservable,
    placeholder: String,
    isSearching: Binding<Bool>,
    dismissButtonTitle: String = "Cancel",
    dismissButtonCallback: (() -> Void)? = nil
  ) {
    self.searchTextWrapper = searchTextWrapper
    self.placeholder = placeholder
    self._isSearching = isSearching
    self.dismissButtonTitle = dismissButtonTitle
    self.dismissButtonCallback = dismissButtonCallback

    self.searchCancellable = searchTextWrapper.searchSubject.sink(receiveValue: { value in
      isSearching.wrappedValue = !value.isEmpty
    })
  }

  var body: some View {
    GeometryReader { reader in
      HStack(alignment: .center, spacing: 0) {
        Image(systemName: "magnifyingglass")

        TextField(
          self.placeholder,
          text: self.$searchTextWrapper.searchText
        )
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding(.horizontal)

        if !self.searchTextWrapper.searchText.isEmpty {
          Button(
            action: {
              self.searchTextWrapper.searchText = ""
              self.isSearching = false
              self.dismissButtonCallback?()
            },
            label: {
              Text(self.dismissButtonTitle).foregroundColor(.pink)
            }
          )
          .buttonStyle(BorderlessButtonStyle())
          .animation(.easeInOut)
        }
      }
      .padding(4)
    }
    .frame(height: 44)
  }
}

#if DEBUG
struct SearchField_Previews : PreviewProvider {
  static var previews: some View {
    let withText = SearchTextObservable()
    withText.searchText = "Test"

    return VStack {
      SearchField(searchTextWrapper: SearchTextObservable(),
                  placeholder: "Search anything",
                  isSearching: .constant(false))
      SearchField(searchTextWrapper: withText,
                  placeholder: "Search anything",
                  isSearching: .constant(false))

      List {
        SearchField(searchTextWrapper: withText,
                    placeholder: "Search anything",
                    isSearching: .constant(false))
        Section(header: SearchField(searchTextWrapper: withText,
                                    placeholder: "Search anything",
                                    isSearching: .constant(false)))
        {
          SearchField(searchTextWrapper: withText,
                      placeholder: "Search anything",
                      isSearching: .constant(false))
        }
      }

      List {
        SearchField(searchTextWrapper: withText,
                    placeholder: "Search anything",
                    isSearching: .constant(false))
        Section(header: SearchField(searchTextWrapper: withText,
                                    placeholder: "Search anything",
                                    isSearching: .constant(false)))
        {
          SearchField(searchTextWrapper: withText,
                      placeholder: "Search anything",
                      isSearching: .constant(false))
        }
      }.listStyle(GroupedListStyle())
    }
  }
}
#endif
