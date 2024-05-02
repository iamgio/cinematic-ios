import SwiftUI

struct MovieView: View {
    @Bindable var vm: MovieViewModel
    
    private func content(movie: Movie) -> some View {
        VStack(spacing: 16) {
            MoviePoster(movie: movie, withTitle: false, glow: true)
            
            Text(movie.title)
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            
            VStack {
                if let year = movie.year, let runtime = movie.runtime {
                    Text(year + " • " + runtime)
                }
                
                if let genre = movie.genre {
                    Text(genre)
                }
            }
            .foregroundStyle(.secondary)
            
            if let stars = vm.stars {
                StarStrip(amount: stars)
                    .padding(.vertical)
            }
            
            VStack(alignment: .leading) {
                if let plot = movie.plot {
                    Text(plot)
                }
                
                if let director = movie.director {
                    Text("movie.director \(director)")
                        .foregroundStyle(.secondary)
                        .padding(.vertical)
                }
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
