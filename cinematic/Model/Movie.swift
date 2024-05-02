import Foundation

struct Movie: ThumbnailMovie {
    var id: String?
    var title: String
    var plot: String
    var genre: String
    var director: String
    var runtime: String
    var year: String
    var rating: Int?
    var image: String?
    
    var thumbnailTitle: String { title }
}

protocol ThumbnailMovie: Identifiable {
    var id: String? { get }
    var thumbnailTitle: String { get }
    var image: String? { get }
}

extension MovieEntity: ThumbnailMovie {
    var thumbnailTitle: String {
        self.title ?? ""
    }
}

struct DecodableMovie: Decodable {
    var imdbID: String
    var Title: String
    var Plot: String
    var Genre: String
    var Director: String
    var Runtime: String
    var Year: String
    var Metascore: String?
    var Poster: String?
    
    func toMovie() -> Movie {
        Movie(
            id: imdbID,
            title: Title,
            plot: Plot,
            genre: Genre,
            director: Director,
            runtime: Runtime,
            year: Year,
            rating: Metascore.flatMap { Int($0) },
            image: Poster
        )
    }
}
