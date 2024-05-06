import SwiftUI

struct BiometricsLoginView: View {
    
    var withError: Bool
    
    @Environment(AuthViewModel.self) private var auth
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                Image(systemName: withError ? "exclamationmark.lock.fill" : "shared.with.you")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 8)
                
                Text(withError ? "login.errortitle" : "login.title")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 4)
                
                Text(withError ? "login.errorsubtitle" : "login.subtitle")
                    .foregroundStyle(.secondary)
                
                if !withError {
                    Spacer()
                } else {
                    Button("login.retry") {
                        auth.loginSuccess = nil
                        auth.biometricsAuth()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .padding(.vertical, 32)
        }
    }
}

#Preview {
    Group {
        BiometricsLoginView(withError: false)
        BiometricsLoginView(withError: true)
    }
    .environment(AuthViewModel())
}
