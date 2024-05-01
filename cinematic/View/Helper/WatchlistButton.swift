import SwiftUI

struct WatchlistButton: View {
    @Binding var isInWatchlist: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isInWatchlist.toggle()
            }
        } label: {
            Label(
                isInWatchlist ? "movie.inwatchlist" : "movie.notinwatchlist",
                systemImage: isInWatchlist ? "checkmark" : "plus"
            )
            .bold()
        }
        .foregroundStyle(.primary)
    }
}

#Preview {
    Group {
        WatchlistButton(isInWatchlist: .constant(true))
        WatchlistButton(isInWatchlist: .constant(false))
    }
}
