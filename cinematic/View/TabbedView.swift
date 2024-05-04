//

import SwiftUI

struct TabbedView: View {
    @State private var selection = 2
    
    var body: some View {
        let userVm = UserViewModel()
        TabView(selection: $selection) {
            TrophiesView()
                .tag(0)
                .tabItem {
                    Label("trophies.title", systemImage: "trophy")
                }
            
            SearchView(vm: SearchViewModel())
                .tag(1)
                .tabItem {
                    Label("search.title", systemImage: "magnifyingglass")
                }
            
            UserView(vm: userVm)
                .tag(2)
                .tabItem {
                    Label("user.title", systemImage: "person")
                }
            
            SettingsView()
                .tag(3)
                .tabItem {
                    Label("settings.title", systemImage: "gear")
                }
        }
        .environment(userVm)
    }
}

#Preview {
    TabbedView()
}
