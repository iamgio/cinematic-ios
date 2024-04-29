import Foundation

@Observable class MovieViewModel {
    let movieId: String
    
    var movie: Movie? = nil
    
    init(movieId: String) {
        self.movieId = movieId
    }
    
    func load() async {
        do {
            let movie = try await OmdbApi.getMovie(id: movieId)
            DispatchQueue.main.sync {
                self.movie = movie
            }
        } catch {
            print("Error loading movie: \(error)")
        }
    }
}
