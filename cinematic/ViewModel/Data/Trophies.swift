import Foundation

enum Trophies {
    private static func trophy(name: String) -> TrophyEntity {
        let trophy = TrophyEntity(context: PersistenceController.shared.context)
        trophy.name = name
        trophy.unlockedDate = Date()
        
        return trophy
    }
    
    static var registration: TrophyEntity { trophy(name: "registration") }
    
    static var watched: TrophyEntity { trophy(name: "watched") }
    
    static var favorite: TrophyEntity { trophy(name: "favorite") }
    
    static var watchlist: TrophyEntity { trophy(name: "watchlist") }
    
    static var search: TrophyEntity { trophy(name: "search") }
    
    static var edit: TrophyEntity { trophy(name: "edit") }
    
    static var all: [TrophyEntity] {
        [registration, edit, watched, favorite, watchlist, search]
    }
}
