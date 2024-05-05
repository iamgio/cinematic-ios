import SwiftUI

struct NewTrophyNotification: View {
    var trophy: Trophy
    
    var body: some View {
        Label {
            Text("trophy.unlocked")
                .bold()
            +
            Text(" ")
            +
            Text(LocalizedStringKey("trophy." + trophy.title))
        } icon: {
            Image(systemName: "trophy.fill")
                .foregroundStyle(.accent)
        }
        .padding(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
        .background(.overlayPrimary)
        .cornerRadius(16)
    }
}

#Preview {
    NewTrophyNotification(trophy: SimpleTrophy(title: "mock"))
}
