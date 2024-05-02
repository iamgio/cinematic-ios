import SwiftUI

struct SearchView: View {
    /// Search is performed only if the search query is long enough.
    private static let minQueryLength = 5
    
    @Bindable var vm: SearchViewModel
    
    var body: some View {
        NavigationStack {
            MovieCollectionShowcase(movies: vm.results, type: .grid)
                .animation(.easeIn, value: vm.results)
                .padding(.horizontal)
                .background(Color.background.ignoresSafeArea())
                .navigationTitle("search.title")
                .searchable(text: $vm.query, prompt: "search.query.prompt")
                .onChange(of: vm.query) { 
                    // Min query length
                    if vm.query.count >= SearchView.minQueryLength {
                        Task {
                            await vm.perform()
                        }
                    }
                }
        }
    }
}

#Preview {
    SearchView(vm: SearchViewModel())
}
