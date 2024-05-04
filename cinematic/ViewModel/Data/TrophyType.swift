import Foundation

enum TrophyType {
    private static func trophy(name: String) -> TrophyEntity {
        var trophy = TrophyEntity(context: PersistenceController.shared.context)
        trophy.name = name
        trophy.unlockedDate = Date()
        
        return trophy
    }
    
    static var registration: TrophyEntity { trophy(name: "registration") }
}
