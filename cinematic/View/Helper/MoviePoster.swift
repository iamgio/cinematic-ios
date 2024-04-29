import SwiftUI

struct MoviePoster: View {
    var movie: Movie
    
    var body: some View {
        let width = 100.0
        let height = 148.0
        let cornerRadius = 8.0
        
        let placeholder = RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: width, height: height)
            .foregroundStyle(.orange)
        
        if let imageUrl = movie.image {
            AsyncImage(
                url: URL(string: imageUrl),
                content: { image in image
                        .resizable()
                        .frame(width: width, height: height)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                },
                placeholder: { placeholder }
            )
        } else {
            placeholder
        }
    }
}
