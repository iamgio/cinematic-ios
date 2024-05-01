import Foundation
import CoreData

@Observable class MovieViewModel {
    let movieId: String
    
    var movie: Movie? = nil
    var entity: MovieEntity? = nil
    
    init(movieId: String) {
        self.movieId = movieId
    }
    
    var stars: Int? {
        guard let rating = movie?.rating else { return nil }
        return Int((Double(rating) / 20.0).rounded())
    }
    
    var isWatched = false {
        willSet {
            entity?.watched = newValue
            
            if newValue {
                self.isInWatchlist = false
            }
            
            PersistenceController.shared.save()
        }
    }
    
    var isInWatchlist = false {
        willSet {
            entity?.inWatchlist = newValue
            PersistenceController.shared.save()
        }
    }
    
    func load() async {
        do {
            let movie = try await OmdbApi.getMovie(id: movieId)
            
            let entity = PersistenceController.shared.fetch(
                request: DataRequests.getMovie(id: movieId),
                orDefault: { MovieEntity(context: PersistenceController.shared.context) }
            ) { $0.first }
            
            entity.id = movieId
            entity.title = movie.title
            entity.image = movie.image
            
            DispatchQueue.main.sync {
                self.movie = movie
                self.entity = entity
                self.isWatched = entity.watched
                self.isInWatchlist = entity.inWatchlist
                PersistenceController.shared.save()
            }
        } catch {
            print("Error loading movie: \(error)")
        }
    }
}
