//
//  ViewState.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 29/12/22.
//

import Foundation

enum ViewState<T, E: Error> {
    case idle
    case loaded(_ data: T)
    case failed(_ error: E)
}
