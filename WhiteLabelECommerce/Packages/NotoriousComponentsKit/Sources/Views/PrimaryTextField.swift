import SwiftUI

public struct PrimaryTextField: TextFieldStyle {
  public init() { }

  // swiftlint:disable:next identifier_name
  public func _body(configuration: TextField<Self._Label>) -> some View {
    VStack {
      configuration
        .colorMultiply(.white)
        .foregroundColor(.white)

      Rectangle()
        .frame(height: 1, alignment: .bottom)
        .foregroundColor(.white)
    }
  }
}
