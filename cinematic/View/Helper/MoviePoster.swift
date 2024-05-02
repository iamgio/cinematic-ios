import SwiftUI

struct MoviePoster: View {
    var movie: any ThumbnailMovie
    var withTitle: Bool
    var glow: Bool = false
    
    var body: some View {
        let width = 100.0
        let height = 148.0
        let cornerRadius = 8.0
        
        let placeholder = RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: width, height: height)
            .foregroundStyle(.orange)
        
        // Async image builder
        let imageBuilder: (Image) -> some View = { image in
            image
                .resizable()
                .frame(width: width, height: height)
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
                                    .blur(radius: 60)
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
            }
        }
    }
}
