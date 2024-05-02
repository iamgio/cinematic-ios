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
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(vm.results) { movie in
                            NavigationLink {
                                if let id = movie.id {
                                    MovieView(vm: MovieViewModel(movieId: id))
                                }
                            } label: {
                                MoviePoster(movie: movie, withTitle: true)
                                    .padding(.top)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .onAppear {
                vm.query = "Inception"
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
