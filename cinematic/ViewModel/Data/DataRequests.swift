import Foundation
import CoreData

struct DataRequests {
    private init() {}
    
    static func getMovie(id: String) -> NSFetchRequest<MovieEntity> {
        let request = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        return request
    }
    
    static func getUser() -> NSFetchRequest<UserEntity> {
        let request = UserEntity.fetchRequest()
        request.fetchLimit = 1
        
        return request
    }
    
    static func getWatched() -> NSFetchRequest<MovieEntity> {
        let request = MovieEntity.fetchRequest()
        request.predicate = NSPredicate(format: "watched == true")
        
        return request
    }
}
