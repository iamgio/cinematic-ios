import SwiftUI

struct ContentView: View {
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
            // TODO depend on settings
            auth.biometricsAuth()
        }
    }
}

#Preview {
    ContentView()
}
