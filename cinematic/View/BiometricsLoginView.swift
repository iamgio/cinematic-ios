import SwiftUI

struct BiometricsLoginView: View {
    
    var withError: Bool
    
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
}
