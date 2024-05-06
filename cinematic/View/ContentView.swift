import SwiftUI

struct ContentView: View {
    @AppStorage(SettingsKeys.theme) private var theme: AppTheme = .system
    @AppStorage(SettingsKeys.useBiometrics) private var useBiometrics: Bool = false
    
    private let auth = AuthViewModel()
    private let user = UserViewModel()
    
    var body: some View {
        Group {
            if !auth.userExists && !auth.registerSuccess {
                RegisterView(vm: auth)
            } else if auth.loginSuccess == true {
                TabbedView()
            } else {
                BiometricsLoginView(withError: auth.loginSuccess == false)
            }
        }
        .onAppear {
            if auth.userExists {
                if useBiometrics {
                    auth.biometricsAuth()
                } else {
                    auth.loginSuccess = true
                }
            }
        }
        .preferredColorScheme(theme.toSwiftUITheme())
        .environment(user)
        .environment(auth)
        .overlay(alignment: .top) {
            // Shows a notification if a new trophy is unlocked
            if let trophy = user.newTrophy {
                NewTrophyNotification(trophy: trophy)
                    .padding(.top)
                    .transition(.move(edge: .top).combined(with: .opacity).animation(.easeInOut))
            }
        }
        .onChange(of: user.newTrophy) {
            // Hides the new trophy notification after some time
            if user.newTrophy != nil {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    withAnimation {
                        user.newTrophy = nil
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
