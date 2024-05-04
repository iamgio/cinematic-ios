import SwiftUI
import PhotosUI
import CoreLocation

struct UserView: View {
    @Bindable var vm: UserViewModel
    
    @State private var editMode: EditMode = .inactive
    @State private var locationManager = LocationManager()
    @State private var selectedPhoto: PhotosPickerItem?
    
    private var isEditing: Bool {
        editMode.isEditing == true
    }
    
    private var header: some View {
        HStack {
            let picture = Group {
                if let picture = vm.picture {
                    Image(uiImage: picture)
                        .resizable()
                        .clipShape(Circle())
                } else {
                    Circle()
                }
            }
            .frame(width: 36, height: 36)
            .padding(.trailing, 8)
            
            if isEditing {
                // Photo selection
                PhotosPicker(selection: $selectedPhoto, matching: .images) {
                    picture
                }
                .onChange(of: selectedPhoto) {
                    Task {
                        try await vm.updatePicture(photo: selectedPhoto)
                    }
                }
            } else if vm.picture != nil {
                picture
            }
            
            if isEditing {
                TextField("user.name", text: $vm.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.trailing, 8)
            } else {
                Text(vm.name)
                    .font(.largeTitle.bold())
            }
            
            Spacer()
            
            CustomEditButton()
                .environment(\.editMode, $editMode)
        }
    }
    
    private var regularContent: some View {
        VStack(alignment: .leading) {
            if !vm.bio.isEmpty {
                Text(vm.bio)
                    .padding(.bottom, 12)
            }
            
            if !vm.location.isEmpty {
                Button {
                    vm.showLocation = true
                } label: {
                    Label(vm.location, systemImage: "mappin.and.ellipse")
                }
                .foregroundStyle(.secondary)
            }
            
            MovieCollectionShowcase(
                title: "user.watched",
                movies: vm.filteredWatched,
                type: .row, allowFavoriteFilter: true,
                showFavoritesOnly: $vm.showFavoriteWatchedOnly
            )
            .padding(.top, 32)
            
            MovieCollectionShowcase(title: "user.watchlist", movies: vm.watchlist, type: .row)
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
                        
                        // User location fetch
                        Button("user.autolocation", systemImage: "scope") {
                            locationManager.requestLocation()
                        }
                        .onChange(of: locationManager.location) {
                            if let location = locationManager.location {
                                vm.fetchLocationName(location: location)
                            }
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
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                if isEditing {
                    editContent
                } else {
                    VStack(spacing: 0) {
                        header
                            .padding()
                            .padding(.bottom, 4)
                            .background(Color.overlayPrimary.opacity(0.3))
                        
                        Divider()
                        
                        ScrollView {
                            regularContent
                        }
                    }
                }
            }
            .onAppear {
                vm.load()
            }
            .sheet(isPresented: $vm.showLocation) {
                UserLocationMapView(vm: vm)
            }
        }
    }
}

#Preview {
    UserView(vm: UserViewModel())
}
