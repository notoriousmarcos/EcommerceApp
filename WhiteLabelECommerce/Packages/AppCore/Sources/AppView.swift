import SwiftUI

import LoginFeature
import ProductsFeature
import RegistrationFeature
import RootFeature
import TabBarFeature
import WelcomeFeature

import AppState

public struct AppView: View {
    private let appState: Store<AppState>

    public init(appState: Store<AppState>) {
        self.appState = appState
    }

    public var body: some View {
        RootView(
            viewModel: RootViewModel(appState: appState),
            welcomeViewProvider: { welcomeView },
            tabBarViewProvider: { tabBarView }
        )
    }

    var welcomeView: some View {
        WelcomeView(
            viewModel: WelcomeViewModel(appState: appState),
            loginViewProvider: { loginView }
        )
    }

    var loginView: some View {
        LoginView(
            viewModel: LoginViewModel(
                dataService: LoginDataService(),
                onAuth: {
                    appState[\.auth.isAuthorized] = true
                }
            ),
            registrationViewProvider: { registrationView }
        )
    }

    var registrationView: some View {
        RegistrationView(viewModel: RegistrationViewModel())
    }

    var tabBarView: some View {
        TabBarView(providers: [
            homeTabProvider
        ])
    }

    var homeTabProvider: TabViewProvider {
        return TabViewProvider(
            systemImageName: "house.fill",
            tabName: "Home"
        ) {
            return AnyView(Text("First Tab"))
        }
    }
}
