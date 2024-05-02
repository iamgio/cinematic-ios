import Foundation

@Observable class SearchViewModel {
    var query: String = ""
    
    var results: [Movie] = []
    
    func perform() async {
        do {
            let movies = try await OmdbApi.searchMovies(query: query)
            DispatchQueue.main.sync {
                self.results = movies
            }
        } catch {
            print("Error searching movies: \(error)")
        }
    }
}
