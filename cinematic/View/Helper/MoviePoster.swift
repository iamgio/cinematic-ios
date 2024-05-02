import SwiftUI

struct MoviePoster: View {
    var movie: any ThumbnailMovie
    var withTitle: Bool
    
    var body: some View {
        let width = 100.0
        let height = 148.0
        let cornerRadius = 8.0
        
        let placeholder = RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: width, height: height)
            .foregroundStyle(.orange)
        
        VStack {
            if let imageUrl = movie.image {
                AsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in 
                        image
                            .resizable()
                            .frame(width: width, height: height)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
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
