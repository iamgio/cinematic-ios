import SwiftUI

struct SearchView: View {
    /// Search is performed only if the search query is long enough.
    private static let minQueryLength = 5
    
    @Bindable var vm: SearchViewModel
    
    @Environment(UserViewModel.self) var user
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.query.isEmpty {
                    // Placeholder
                    ContentUnavailableView(
                        "search.empty.title",
                        systemImage: "magnifyingglass",
                        description: Text("search.empty.subtitle")
                    )
                } else {
                    MovieCollectionShowcase(movies: vm.results, type: .grid)
                }
            }
            .navigationTitle("search.title")
            .navigationBarTitleDisplayMode(vm.query.isEmpty ? .large : .inline)
            .animation(.easeIn, value: vm.results)
            .padding(.horizontal)
            .background(Color.background.ignoresSafeArea())
            .searchable(text: $vm.query, prompt: "search.query.prompt")
            .onChange(of: vm.query) {
                // Min query length
                if vm.query.count >= SearchView.minQueryLength {
                    Task {
                        await vm.perform()
                    }
                    user.addTrophy(Trophies.search)
                }
            }
        }
    }
}

#Preview {
    SearchView(vm: SearchViewModel())
        .environment(UserViewModel())
}
