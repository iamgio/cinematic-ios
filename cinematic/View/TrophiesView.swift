import SwiftUI

struct TrophiesView: View {
    @Environment(UserViewModel.self) var vm
    
    var body: some View {
        let userTrophies = vm.trophies
        
        NavigationStack {
            List(Trophies.all) { trophy in
                TrophyView(trophy: trophy, owned: userTrophies.contains { $0.title == trophy.title })
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .background(Color.background)
            .scrollContentBackground(.hidden)
            .navigationTitle("trophies.fulltitle")
        }
    }
}

#Preview {
    TrophiesView()
        .environment(UserViewModel())
}
