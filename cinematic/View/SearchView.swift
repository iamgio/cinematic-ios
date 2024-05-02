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
                        
                    } label: {
                        Text("search.perform")
                            .bold()
                            .padding(6)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                List(vm.results) { movie in
                    Text(movie.title)
                }
                .scrollContentBackground(.hidden)
            }
            .padding()
            .background(Color.background.ignoresSafeArea())
            .navigationTitle("search.title")
        }
    }
}

#Preview {
    SearchView(vm: SearchViewModel())
}
