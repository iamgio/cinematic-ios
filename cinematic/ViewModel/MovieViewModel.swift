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
        get {
            let request = DataRequests.getMovie(id: movieId)
            
            return PersistenceController.shared.fetch(request: request, orDefault: false) { result in
                result.first?.watched
            }
        }
        set {
            let request = DataRequests.getMovie(id: movieId)
            
            return PersistenceController.shared.fetch(request: request) { result in
                result.first?.watched = newValue
                PersistenceController.shared.save()
            }
        }
    }
    
    func load() async {
        do {
            let movie = try await OmdbApi.getMovie(id: movieId)
            
            let entity = MovieEntity(context: PersistenceController.shared.context)
            entity.id = movieId
            entity.title = movie.title
            entity.image = movie.image
            
            DispatchQueue.main.sync {
                self.movie = movie
                PersistenceController.shared.save()
            }
        } catch {
            print("Error loading movie: \(error)")
        }
    }
}
