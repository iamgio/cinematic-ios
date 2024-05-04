import SwiftUI

struct TrophyView: View {
    var trophy: Trophy
    var owned: Bool
    
    var body: some View {
        HStack {
            Image(systemName: owned ? "trophy.fill" : "trophy")
                .font(.largeTitle)
                .padding(.horizontal)
                .shadow(color: owned ? .accent : .clear, radius: 16)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(LocalizedStringKey("trophy." + trophy.title))
                    .font(.headline)
                
                Text(LocalizedStringKey("trophy." + trophy.title + ".description"))
                    .font(.caption)
            }
            
            Spacer()
        }
        .padding()
        .background(.overlayPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    TrophyView(trophy: SimpleTrophy(title: "mock"), owned: true)
}
