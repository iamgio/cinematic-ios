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
            
            VStack(spacing: 24) {
                WatchUnwatchButton(isWatched: $vm.isWatched)
                
                if vm.isWatched {
                    FavoriteButton(isFavorite: $vm.isFavorite)
                        .padding(.bottom)
                }
                
                WatchlistButton(isInWatchlist: $vm.isInWatchlist)
                    .foregroundStyle(vm.isWatched ? .secondary : .primary)
            }
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
