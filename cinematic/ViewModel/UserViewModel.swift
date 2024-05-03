import Foundation
import SwiftLocation
import UIKit

@Observable class UserViewModel {
    private var entity: UserEntity? = nil
    
    var name: String = "" {
        willSet {
            entity?.name = newValue
            PersistenceController.shared.save()
        }
    }
    
    var bio: String = "" {
        willSet {
            entity?.bio = newValue
            PersistenceController.shared.save()
        }
    }
    
    var location: String = "" {
        willSet {
            entity?.location = newValue
            PersistenceController.shared.save()
        }
    }
    
    var picture: UIImage? = nil {
        willSet {
            entity?.picture = newValue?.jpegData(compressionQuality: 1.0)
            PersistenceController.shared.save()
        }
    }
    
    var watched: [MovieEntity] = []
    
    var watchlist: [MovieEntity] = []
    
    var showFavoriteWatchedOnly = false
    
    var filteredWatched: [MovieEntity] {
        showFavoriteWatchedOnly ? watched.filter { $0.favorite } : watched
    }
    
    func load() {
        let entity = PersistenceController.shared.fetch(
            request: DataRequests.getUser(),
            orDefault: {
                let user = UserEntity(context: PersistenceController.shared.context)
                user.name = "Username"
                return user
            }
        ) { $0.first }
        
        self.name = entity.name ?? ""
        self.bio = entity.bio ?? ""
        self.location = entity.location ?? ""
        self.picture = entity.picture.map { UIImage(data: $0) ?? UIImage() }
        
        self.watched = PersistenceController.shared.fetch(
            request: DataRequests.getWatched(),
            orDefault: { [] }
        ) { $0.sorted { $0.title ?? "" < $1.title ?? "" } }
        
        self.watchlist = PersistenceController.shared.fetch(
            request: DataRequests.getWatchlist(),
            orDefault: { [] }
        ) { $0.sorted { $0.title ?? "" < $1.title ?? "" } }
        
        self.entity = entity
        PersistenceController.shared.save()
    }
    
    func requestLocationUpdate() async throws {
        // TODO not working yet
        
        let location = Location()
        
        let status = try await location.requestPermission(.whenInUse)
        
        print("Status: \(status)")
        
        print("a")
        
        let userLocation = try await location.requestLocation(timeout: 2)
        
        print("b")
        
        print(userLocation)
        
        DispatchQueue.main.sync {
            self.location = userLocation.description
        }
    }
}
