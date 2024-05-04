import Foundation

protocol Trophy {
    var title: String { get }
}

extension TrophyEntity: Trophy {
    var title: String {
        self.name ?? "-"
    }
}

struct SimpleTrophy: Trophy {
    var title: String
}
