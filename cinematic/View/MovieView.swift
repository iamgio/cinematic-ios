import SwiftUI

struct MovieView: View {
    var vm: MovieViewModel
    
    private func content(movie: Movie) -> some View {
        VStack(spacing: 16) {
            MoviePoster(movie: movie)
                .padding(.top)
            
            Text(movie.title)
                .font(.largeTitle.bold())
            
            VStack {
                Text(movie.year + " • " + movie.runtime)
                Text(movie.genre)
            }
            .foregroundStyle(.secondary)
            
            if let stars = vm.stars {
                StarStrip(amount: stars)
                    .padding(.vertical)
            }
            
            VStack(alignment: .leading) {
                Text(movie.plot)
                
                Text("movie.director \(movie.director)")
                    .foregroundStyle(.secondary)
                    .padding(.vertical)
            }
            .padding(.horizontal)
        }
    }
    
    var body: some View {
        if let movie = vm.movie {
            ScrollView {
                content(movie: movie)
            }
        } else {
            ProgressView()
                .task {
                    await vm.load()
                }
        }
    }
}

#Preview {
    MovieView(vm: MovieViewModel(movieId: "tt1375666"))
}
