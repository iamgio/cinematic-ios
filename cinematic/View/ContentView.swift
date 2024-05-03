import SwiftUI

struct ContentView: View {
    @AppStorage(SettingsKeys.theme) private var theme: AppTheme = .system
    @AppStorage(SettingsKeys.useBiometrics) private var useBiometrics: Bool = false
    
    private let auth = AuthViewModel()
    
    var body: some View {
        Group {
            if auth.loginSuccess == nil {
                Text("Logging in")
            } else if auth.loginSuccess == true {
                TabbedView()
            } else {
                Text("Error")
            }
        }
        .onAppear {
            if useBiometrics {
                auth.biometricsAuth()
            } else {
                auth.loginSuccess = true
            }
        }
        .preferredColorScheme(theme.toSwiftUITheme())
    }
}

#Preview {
    ContentView()
}
