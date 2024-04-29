import SwiftUI

struct MovieView: View {
    var vm: MovieViewModel
    
    private func content(movie: Movie) -> some View {
        VStack(spacing: 16) {
            if let imageUrl = movie.image {
                AsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in image
                            .resizable()
                            .frame(width: 100, height: 148)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    },
                    placeholder: {}
                )
                .padding(.top)
            }
            
            Text(movie.title)
                .font(.largeTitle.bold())
            
            VStack {
                Text(movie.year + " • " + movie.runtime)
                Text(movie.genre)
            }
            .foregroundStyle(.secondary)
            
            if let stars = vm.stars {
                Text(String(stars))
            }
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
