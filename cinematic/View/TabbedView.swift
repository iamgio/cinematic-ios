//

import SwiftUI

struct TabbedView: View {
    var body: some View {
        TabView {
            Text("feed")
                .tabItem {
                    Label("feed.title", systemImage: "house")
                }
            
            SearchView(vm: SearchViewModel())
                .tabItem {
                    Label("search.title", systemImage: "magnifyingglass")
                }
            
            UserView(vm: UserViewModel())
                .tabItem {
                    Label("user.title", systemImage: "person")
                }
        }
    }
}

#Preview {
    TabbedView()
}
