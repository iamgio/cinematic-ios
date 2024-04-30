import Foundation
import CoreData

struct DataRequests {
    private init() {}
    
    static func getMovie(id: String) -> NSFetchRequest<MovieEntity> {
        let request = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        return request
    }
}
