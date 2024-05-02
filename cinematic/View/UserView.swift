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
            Group {
                if let picture = vm.picture {
                    Image(uiImage: picture)
                        .clipShape(Circle())
                } else {
                    Circle()
                }
            }
            .frame(width: 36, height: 36)
            .padding(.trailing, 8)
            
            if isEditing {
                TextField("user.name", text: $vm.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 8)
            } else {
                Text(vm.name)
                    .font(.largeTitle.bold())
            }
            
            Spacer()
            
            EditButton()
        }
    }
    
    private var regularContent: some View {
        VStack(alignment: .leading) {
            header
            
            Divider()
                .padding(.bottom, 24)
            
            if !vm.bio.isEmpty {
                Text(vm.bio)
                    .padding(.bottom, 12)
            }
            
            if !vm.location.isEmpty {
                Label(vm.location, systemImage: "mappin.and.ellipse")
                    .foregroundStyle(.secondary)
            }
            
            MovieRowShowcase(title: "user.watched", movies: vm.watched)
                .padding(.top, 32)
        }
        .padding()
    }
    
    private var editContent: some View {
        VStack {
            header.padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
            
            List {
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
            }
            .scrollContentBackground(.hidden)
        }
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            if isEditing {
                editContent
            } else {
                ScrollView {
                    regularContent
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
