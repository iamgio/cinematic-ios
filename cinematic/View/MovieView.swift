import SwiftUI

struct MovieView: View {
    var vm: MovieViewModel
    
    var body: some View {
        Text(vm.movie?.title ?? "-")
            .task {
                await vm.load()
            }
    }
}

#Preview {
    MovieView(vm: MovieViewModel(movieId: "tt1375666"))
}
