public struct AppState: Equatable {
  public var auth = AuthState()
  public var user = UserData()
  public var routing = ViewRouting()
  public var system = System()

  public init() {}

  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.auth == rhs.auth &&
    lhs.routing == rhs.routing &&
    lhs.system == rhs.system &&
    lhs.user == rhs.user
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
