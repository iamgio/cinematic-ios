import SwiftUI

struct TrophiesView: View {
    @Environment(UserViewModel.self) var vm
    
    var body: some View {
        NavigationStack {
            List(vm.trophies) {
                TrophyView(trophy: $0, owned: true)
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
