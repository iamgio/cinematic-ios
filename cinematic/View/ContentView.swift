import SwiftUI

struct ContentView: View {
    @AppStorage("biometrics") private var useBiometrics: Bool = false
    
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
    }
}

#Preview {
    ContentView()
}
