import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button {
            withAnimation {
                isFavorite.toggle()
            }
        } label: {
            Label {
                Text("movie.favorite")
            } icon: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(.accent)
            }
        }
        .buttonStyle(.plain)
    }
}
