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
}
