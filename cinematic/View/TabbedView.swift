//

import SwiftUI

struct TabbedView: View {
    var body: some View {
        let userVm = UserViewModel()
        TabView {
            Text("feed")
                .tabItem {
                    Label("feed.title", systemImage: "house")
                }
            
            SearchView(vm: SearchViewModel())
                .tabItem {
                    Label("search.title", systemImage: "magnifyingglass")
                }
            
            UserView(vm: userVm)
                .tabItem {
                    Label("user.title", systemImage: "person")
                }
            
            SettingsView()
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
