import SwiftUI

/// A strip of filled/unfilled stars.
struct StarStrip: View {
    /// Amount of filled stars.
    var amount: Int
    
    /// Total stars.
    var max: Int = 5
    
    var body: some View {
        HStack {
            ForEach(0..<max, id: \.self) { i in
                Image(systemName: i < amount ? "star.fill" : "star")
            }
        }
    }
}

#Preview {
    StarStrip(amount: 3)
}
