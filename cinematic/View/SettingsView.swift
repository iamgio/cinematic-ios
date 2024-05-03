import SwiftUI

struct SettingsView: View {
    @AppStorage(SettingsKeys.theme) private var theme: AppTheme = .system
    @AppStorage(SettingsKeys.useBiometrics) private var useBiometrics: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Picker("settings.theme", selection: $theme) {
                        ForEach(AppTheme.allCases, id: \.self) { option in
                            Text(LocalizedStringKey("settings.theme." + option.rawValue))
                                .tag(option)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
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
