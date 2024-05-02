import Foundation
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
    
    var watched: [MovieEntity] {
        return PersistenceController.shared.fetch(
            request: DataRequests.getWatched(),
            orDefault: { [] }
        ) { $0.sorted { $0.title ?? "" < $1.title ?? "" } }
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
        self.entity = entity
        PersistenceController.shared.save()
    }
}
