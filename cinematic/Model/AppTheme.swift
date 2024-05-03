import Foundation
import SwiftUI

enum AppTheme: String, CaseIterable {
    case light
    case dark
    case system
}

extension AppTheme {
    func toSwiftUITheme() -> ColorScheme? {
        switch self {
        case .light:
            .light
        case .dark:
            .dark
        case .system:
            nil
        }
    }
}
