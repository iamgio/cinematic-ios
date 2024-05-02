//

import SwiftUI

struct UserView: View {
    @Bindable var vm: UserViewModel
    
    @Environment(\.editMode) private var editMode
    
    private var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }
    
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
    
    private var regularContent: some View {
        Group {
            header
            
            if !vm.bio.isEmpty {
                Text(vm.bio)
            }
            
            if !vm.location.isEmpty {
                Label(vm.location, systemImage: "mappin.and.ellipse")
                    .foregroundStyle(.secondary)
            }
            
            EditButton()
        }
        .padding()
    }
    
    private var editContent: some View {
        List {
            Section {
                TextField("user.name", text: $vm.name)
            } header: {
                Text("user.name")
            }
            
            Section {
                TextEditor(text: $vm.bio)
            } header: {
                Text("user.bio")
            }
            
            Section {
                HStack {
                    TextField("user.location", text: $vm.location)
                    Button("user.autolocation", systemImage: "scope") {
                        vm.location = "New York" // TODO get from GPS
                    }
                    .labelStyle(.iconOnly)
                }
            } header: {
                Text("user.location")
            }
            
            EditButton()
        }
        .listRowBackground(Color.overlayPrimary)
        .scrollContentBackground(.hidden)
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            if isEditing {
                editContent
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        regularContent
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
