import SwiftUI

struct MovieView: View {
    @Bindable var vm: MovieViewModel
    
    private func content(movie: Movie) -> some View {
        VStack(spacing: 16) {
            MoviePoster(movie: movie, withTitle: false)
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
            
            WatchUnwatchButton(isWatched: $vm.isWatched)
            
            WatchlistButton(isInWatchlist: $vm.isInWatchlist)
                .padding(.top, 8)
        }
    }
    
    var body: some View {
        Group {
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
        .background(Color.background.ignoresSafeArea())
    }
}

#Preview {
    MovieView(vm: MovieViewModel(movieId: "tt0816692"))
}
