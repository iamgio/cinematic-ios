import SwiftUI

struct RegisterView: View {
    @Bindable var vm: AuthViewModel
    
    @FocusState private var focus: Bool
    
    private var content: some View {
        VStack {
            Text("register.title")
                .font(.largeTitle.bold())
                .padding(.bottom, 8)
            
            Text("register.subtitle")
                .font(.subheadline)
                .padding(.bottom, 64)
            
            TextField("user.name", text: $vm.registerUsername)
                .padding(12)
                .background(Color.overlayPrimary)
                .cornerRadius(8)
                .padding(.bottom)
                .focused($focus, equals: true)
            
            Button {
                withAnimation {
                    vm.register()
                }
            } label: {
                Text("user.register")
                    .bold()
                    .padding(6)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .onAppear {
            focus = true
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                content.padding(.horizontal)
            }
        }
    }
}

#Preview {
    RegisterView(vm: AuthViewModel())
}
