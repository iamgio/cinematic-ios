import SwiftUI

struct SettingsView: View {
    @AppStorage("biometrics") private var useBiometrics = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle("settings.biometrics", isOn: $useBiometrics)
                } footer: {
                    Text("settings.biometrics.description")
                }
            }
            .navigationTitle("settings.title")
            .scrollContentBackground(.hidden)
            .background(Color.background)
            .tint(.accent)
        }
    }
}

#Preview {
    SettingsView()
}
