import Foundation

struct Movie {
    var title: String
    var plot: String
    var genre: String
    var director: String
    var runtime: String
    var releaseDate: String
    var rating: Int?
    var image: String?
}

struct DecodableMovie: Decodable {
    var Title: String
    var Plot: String
    var Genre: String
    var Director: String
    var Runtime: String
    var Released: String
    var Metascore: String?
    var Poster: String?
    
    func toMovie() -> Movie {
        Movie(
            title: Title,
            plot: Plot,
            genre: Genre,
            director: Director,
            runtime: Runtime,
            releaseDate: Released,
            rating: Metascore.flatMap { Int($0) },
            image: Poster
        )
    }
}
