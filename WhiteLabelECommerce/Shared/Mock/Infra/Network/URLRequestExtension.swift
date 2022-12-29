//
//  URLRequestExtension.swift
//  WhiteLabelECommerce
//
//  Created by Marcos Vinicius Brito on 24/02/22.
//

import Foundation

#if DEBUG
extension URLRequest {
    var identifier: String {
        self.description
    }
}
#endif
