import Foundation
import CoreData

@Observable class MovieViewModel {
    let movieId: String
    
    var movie: Movie? = nil
    
    init(movieId: String) {
        self.movieId = movieId
    }
    
    var stars: Int? {
        guard let rating = movie?.rating else { return nil }
        return Int((Double(rating) / 20.0).rounded())
    }
    
    var isWatched: Bool {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        request.predicate = NSPredicate(format: "id == %@", movieId)
        
        return PersistenceController.shared.fetch(request: request, orDefault: false) { result in
            result.first?.watched
        }
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
