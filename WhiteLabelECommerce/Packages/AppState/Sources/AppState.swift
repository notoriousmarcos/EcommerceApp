import ShopCore

public struct AppState: Equatable {
  public var auth = AuthState()
  public var user = UserData()
  public var shopCart = ShopCart()
  public var system = System()

  public init() {}

  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.auth == rhs.auth &&
    lhs.shopCart == rhs.shopCart &&
    lhs.system == rhs.system &&
    lhs.user == rhs.user
  }
}

public extension AppState {
  struct ShopCart: Equatable {
    // TODO: - inject this dependencies and user info.
    public var cart = Cart(userId: 1, date: .now, products: [])
  }
}

public extension AppState {
  struct AuthState: Equatable {
    public var isAuthorized = false
  }
}

public extension AppState {
  struct UserData: Equatable {
    var id: String?
  }
}

public extension AppState {
  struct ViewRouting: Equatable { }
}

public extension AppState {
  struct System: Equatable {
    var isActive = false
  }
}
