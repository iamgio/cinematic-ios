import SwiftUI

struct MoviePoster: View {
    static let width = 100.0
    static let height = 148.0
    
    var movie: any ThumbnailMovie
    var withTitle: Bool
    var glow: Bool = false
    
    var body: some View {
        let cornerRadius = 8.0
        
        let placeholder = RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: MoviePoster.width, height: MoviePoster.height)
            .foregroundStyle(.moviePlaceholder)
        
        // Async image builder
        let imageBuilder: (Image) -> some View = { image in
            image
                .resizable()
                .frame(width: MoviePoster.width, height: MoviePoster.height)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        
        VStack {
            if let imageUrl = movie.image {
                AsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in
                        // If the poster should have a glow effect
                        if glow {
                            ZStack {
                                imageBuilder(image)
                                    .blur(radius: 70)
                                    .offset(y: -20)
                                imageBuilder(image)
                            }
                        } else {
                            imageBuilder(image)
                        }
                    },
                    placeholder: { placeholder }
                )
            } else {
                placeholder
            }
            
            if withTitle {
                Text(movie.thumbnailTitle)
                    .font(.caption)
                    .padding(.top, 2)
                    .lineLimit(2, reservesSpace: true)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: MoviePoster.width)
            }
        }
    }
}
