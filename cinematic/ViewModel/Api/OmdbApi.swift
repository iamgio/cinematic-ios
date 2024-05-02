import Foundation

struct OmdbApi {
    private init() {}
    
    static func getMovie(title: String) async throws -> Movie {
        let movie: DecodableMovie = try await sendGetRequest(endpoint: "t=\(title)")
        return movie.toMovie()
    }
    
    static func getMovie(id: String) async throws -> Movie {
        let movie: DecodableMovie = try await sendGetRequest(endpoint: "i=\(id)")
        return movie.toMovie()
    }
    
    static func searchMovies(query: String) async throws -> [Movie] {
        let wrapper: MovieSearchWrapper = try await sendGetRequest(endpoint: "s=\(query)")
        return wrapper.Search.map { $0.toMovie() }
    }
}
