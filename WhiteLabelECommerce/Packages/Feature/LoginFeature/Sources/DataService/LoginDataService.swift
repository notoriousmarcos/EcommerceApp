import Foundation

public protocol LoginDataServiceType {
}

public class LoginDataService: LoginDataServiceType {
  public init() {}

  deinit {
#if DEBUG
    print("Deinit \(Self.self)")
#endif
  }
}
