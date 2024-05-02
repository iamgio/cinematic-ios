import SwiftUI

struct SearchView: View {
    /// Search is performed only if the search query is long enough.
    private static let minQueryLength = 5
    
    @Bindable var vm: SearchViewModel
    
    var body: some View {
        NavigationStack {
            MovieCollectionShowcase(movies: vm.results, type: .grid)
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
                    }
                }
        }
    }
}

#Preview {
    SearchView(vm: SearchViewModel())
}
