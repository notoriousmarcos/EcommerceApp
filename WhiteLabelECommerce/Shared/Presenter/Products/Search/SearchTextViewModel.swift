//
//  SearchTextObservable.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 03/07/23.
//

import Combine
import SwiftUI

class SearchTextViewModel: ObservableObject {
  @Published var searchText = "" {
    willSet {
      DispatchQueue.main.async {
        self.searchSubject.send(newValue)
      }
    }
    didSet {
      DispatchQueue.main.async {
        self.onUpdateText?(self.searchText)
      }
    }
  }

  var onUpdateText: ((String) -> Void)?
  var onUpdateTextDebounced: ((String) -> Void)?
  let searchSubject = PassthroughSubject<String, Never>()

  private var searchCancellable: Cancellable? {
    didSet {
      oldValue?.cancel()
    }
  }

  deinit {
    searchCancellable?.cancel()
  }

  init(
    onUpdateText: ((String) -> Void)? = nil,
    onUpdateTextDebounced: ((String) -> Void)? = nil
  ) {
    self.onUpdateText = onUpdateText
    self.onUpdateTextDebounced = onUpdateTextDebounced
    searchCancellable = searchSubject.eraseToAnyPublisher()
      .map { $0 }
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .removeDuplicates()
      .filter { !$0.isEmpty }
      .sink(receiveValue: { searchText in
        self.onUpdateTextDebounced?(searchText)
      })
  }
}
