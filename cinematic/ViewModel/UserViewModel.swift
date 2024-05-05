import Foundation
import PhotosUI
import CoreLocation
import SwiftUI

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
            locationCoordinate = nil
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
    
    var showLocation = false
    
    var locationCoordinate: CLLocationCoordinate2D? = nil
    
    var filteredWatched: [MovieEntity] {
        showFavoriteWatchedOnly ? watched.filter { $0.favorite } : watched
    }
    
    var trophies: [TrophyEntity] {
        guard let trophies = entity?.trophies as? Set<TrophyEntity> else { return [] }
        return trophies.sorted { ($0.unlockedDate ?? Date()) > ($1.unlockedDate ?? Date()) }
    }
    
    // Latest unlocked trophy to display as a notification
    var newTrophy: TrophyEntity? = nil
    
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
    
    func fetchLocationCoordinate() {
        GeoUtils().getCoordinate(address: location) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            self.locationCoordinate = coordinate
        }
    }
    
    func fetchLocationName(location: CLLocation) {
        GeoUtils().getLocationName(location: location) { city, country, error in
            if let city, let country {
                self.location = "\(city), \(country)"
            }
        }
    }
    
    func updatePicture(photo: PhotosPickerItem?) async throws {
        guard let photo else {
            self.picture = nil
            return
        }
        
        let data = try await photo.loadTransferable(type: Data.self)
        if let data {
            DispatchQueue.main.sync {
                self.picture = UIImage(data: data)
            }
        }
    }
    
    func hasTrophy(_ trophy: TrophyEntity) -> Bool {
        (entity?.trophies as? Set<TrophyEntity>)?.contains { $0.name == trophy.name } == true
    }
    
    func addTrophy(_ trophy: TrophyEntity) {
        // Don't add if the user already owns the trophy.
        if !self.hasTrophy(trophy) {
            entity?.addToTrophies(trophy)
            newTrophy = trophy
        }
    }
}
