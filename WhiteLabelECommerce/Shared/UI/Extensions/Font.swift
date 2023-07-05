//
//  Font.swift
//  WhiteLabelECommerceApp
//
//  Created by Marcos Vinicius Brito on 17/02/22.
//

import Foundation
import SwiftUI

public extension Font {
    static func fHACondFrenchNC(size: CGFloat) -> Font {
        return Font.custom("FHA Condensed French NC", size: size)
    }

    static func americanCaptain(size: CGFloat) -> Font {
        return Font.custom("American Captain", size: size)
    }

    static func fjallaOne(size: CGFloat) -> Font {
        return Font.custom("FjallaOne-Regular", size: size)
    }
}

struct TitleFont: ViewModifier {
    let size: CGFloat

    func body(content: Content) -> some View {
        return content.font(.fjallaOne(size: size))
    }
}

extension View {
    func titleFont(size: CGFloat) -> some View {
        return ModifiedContent(content: self, modifier: TitleFont(size: size))
    }

    func titleStyle() -> some View {
        return ModifiedContent(content: self, modifier: TitleFont(size: 16))
    }
}
