import SwiftUI

struct MovieView: View {
    @Bindable var vm: MovieViewModel
    
    @Environment(UserViewModel.self) var user
    
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
                    .onChange(of: vm.isWatched) {
                        if vm.isWatched {
                            user.addTrophy(Trophies.watched)
                        }
                    }
                
                if vm.isWatched {
                    FavoriteButton(isFavorite: $vm.isFavorite)
                        .padding(.bottom)
                        .onChange(of: vm.isFavorite) {
                            if vm.isFavorite {
                                user.addTrophy(Trophies.favorite)
                            }
                        }
                }
                
                WatchlistButton(isInWatchlist: $vm.isInWatchlist)
                    .foregroundStyle(vm.isWatched ? .secondary : .primary)
                    .onChange(of: vm.isInWatchlist) {
                        if vm.isInWatchlist {
                            user.addTrophy(Trophies.watchlist)
                        }
                    }
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
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
}

#Preview {
    MovieView(vm: MovieViewModel(movieId: "tt0816692"))
        .environment(UserViewModel())
}
