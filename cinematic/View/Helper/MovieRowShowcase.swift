//

import SwiftUI

struct MovieRowShowcase<Movie: ThumbnailMovie>: View {
    var title: LocalizedStringKey
    var movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title.bold())
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(movies) { movie in
                        NavigationLink {
                            if let id = movie.id {
                                MovieView(vm: MovieViewModel(movieId: id))
                            }
                        } label: {
                            MoviePoster(movie: movie, withTitle: true)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

#Preview {
    MovieRowShowcase(
        title: "Section",
        movies: PersistenceController.shared.fetch(
            request: MovieEntity.fetchRequest(),
            orDefault: { [] }
        ) { $0.sorted { $0.title ?? "" < $1.title ?? "" } }
    )
}
