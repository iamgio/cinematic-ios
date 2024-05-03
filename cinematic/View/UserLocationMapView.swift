//

import SwiftUI

struct UserLocationMapView: View {
    var vm: UserViewModel
    
    var body: some View {
        NavigationStack {
            if let coordinate = vm.locationCoordinate {
                MapView(coordinate: coordinate)
                    .navigationTitle(vm.location)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("modal.close") {
                            vm.showLocation = false
                        }
                    }
            } else {
                ProgressView()
                    .onAppear {
                        vm.fetchLocationCoordinate()
                    }
            }
        }
    }
}
