import SwiftUI

struct WatchUnwatchButton: View {
    @Binding var isWatched: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isWatched.toggle()
            }
        } label: {
            Label(
                isWatched ? "movie.watched" : "movie.unwatched",
                systemImage: isWatched ? "checkmark" : "plus"
            )
            .bold()
            .padding(EdgeInsets(
                top: 8, leading: 20, bottom: 8, trailing: 24
            ))
        }
        .buttonStyle(.borderedProminent)
        .foregroundColor(isWatched ? .confirm : .primary)
        .tint(isWatched ? .confirmBackground : .overlayPrimary)
    }
}

#Preview {
    Group {
        WatchUnwatchButton(isWatched: .constant(false))
        WatchUnwatchButton(isWatched: .constant(true))
    }
}
