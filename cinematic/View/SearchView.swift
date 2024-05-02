import SwiftUI

struct SearchView: View {
    @Bindable var vm: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("search.query", text: $vm.query, prompt: Text("search.query.prompt"))
                        .padding(12)
                        .background(Color.overlayPrimary)
                        .cornerRadius(8)
                    
                    Button {
                        Task {
                            await vm.perform()
                        }
                    } label: {
                        Text("search.perform")
                            .bold()
                            .padding(6)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                MovieCollectionShowcase(movies: vm.results, type: .grid)
            }
            .padding(.horizontal)
            .padding(.top)
            .background(Color.background.ignoresSafeArea())
            .navigationTitle("search.title")
        }
    }
}

#Preview {
    SearchView(vm: SearchViewModel())
}
