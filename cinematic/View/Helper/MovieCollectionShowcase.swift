import SwiftUI

struct MovieCollectionShowcase<Movie: ThumbnailMovie>: View {
    var title: LocalizedStringKey = ""
    var movies: [Movie]
    @State var type: DisplayType
    
    var allowFavoriteFilter: Bool = false
    var showFavoritesOnly: Binding<Bool> = .constant(false)
    
    enum DisplayType {
        case row
        case grid
    }
    
    /// A button that shows this row showcase as a grid on a new page.
    private var switchToGridButton: some View {
        NavigationLink {
            ZStack {
                Color.background.ignoresSafeArea()
                
                MovieCollectionShowcase(
                    title: title,
                    movies: movies,
                    type: .grid,
                    allowFavoriteFilter: allowFavoriteFilter,
                    showFavoritesOnly: showFavoritesOnly
                )
                .padding()
            }
        } label: {
            Label("movies.rowtogrid", systemImage: "square.grid.2x2")
                .labelStyle(.iconOnly)
                .font(.title3)
                .opacity(0.8)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.title.bold())
                
                if type == .row && !movies.isEmpty {
                    switchToGridButton.padding(.trailing, 24)
                }
                
                Spacer()
                
                if allowFavoriteFilter {
                    Button {
                        withAnimation {
                            showFavoritesOnly.wrappedValue.toggle()
                        }
                    } label: {
                        Label("movies.favoritesonly", systemImage: showFavoritesOnly.wrappedValue ? "heart.fill" : "heart")
                    }
                }
            }
            
            if movies.isEmpty {
                Text("movies.empty")
                    .padding(.vertical, 1)
                    .foregroundStyle(.secondary)
            }
            
            let content =
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
            
            switch self.type {
            case .row:
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        content
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.horizontal, -16) // Removes unscrollable padding
            case .grid:
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: MoviePoster.width))]) {
                        content.padding(.top)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MovieCollectionShowcase(
            title: "Section",
            movies: PersistenceController.shared.fetch(
                request: MovieEntity.fetchRequest(),
                orDefault: { [] }
            ) { $0.sorted { $0.title ?? "" < $1.title ?? "" } },
            type: .row
        )
    }
}
