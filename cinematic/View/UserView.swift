//

import SwiftUI

struct UserView: View {
    @Bindable var vm: UserViewModel
    
    private var header: some View {
        HStack {
            Text(vm.name)
                .font(.largeTitle.bold())
            
            Spacer()
            
            Group {
                if let picture = vm.picture {
                    Image(uiImage: picture)
                        .clipShape(Circle())
                } else {
                    Circle()
                }
            }
            .frame(width: 40, height: 40)
        }
    }
    
    private var content: some View {
        Group {
            header
            
            if let bio = vm.bio {
                Text(bio)
            }
            
            if let location = vm.location {
                Text(location)
            }
        }
        .padding()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 16) {
                        content
                    }
                }
            }
        }
        .onAppear {
            vm.load()
        }
    }
}

#Preview {
    UserView(vm: UserViewModel())
}
