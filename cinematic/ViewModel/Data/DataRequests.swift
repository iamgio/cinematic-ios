import Foundation
import CoreData

struct DataRequests {
    private init() {}
    
    static func getMovie(id: String) -> NSFetchRequest<MovieEntity> {
        let request = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        request.predicate = NSPredicate(format: "id == %@", id)
        
        return request
    }
}
