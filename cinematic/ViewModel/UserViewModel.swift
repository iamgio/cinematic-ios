import Foundation
import UIKit

@Observable class UserViewModel {
    private var entity: UserEntity? = nil
    
    var name: String {
        entity?.name ?? "-"
    }
    
    var bio: String? = nil {
        willSet {
            entity?.bio = newValue
            PersistenceController.shared.save()
        }
    }
    
    var location: String? = nil {
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
    
    func load() {
        let entity = PersistenceController.shared.fetch(
            request: DataRequests.getUser(),
            orDefault: {
                let user = UserEntity(context: PersistenceController.shared.context)
                user.name = "Username"
                return user
            }
        ) { $0.first }
        
        self.bio = entity.bio
        self.location = entity.location
        self.picture = entity.picture.map { UIImage(data: $0) ?? UIImage() }
        self.entity = entity
        PersistenceController.shared.save()
    }
}
