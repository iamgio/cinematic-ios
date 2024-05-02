//

import SwiftUI

struct CustomEditButton: View {
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        Button {
            withAnimation {
                switch editMode?.wrappedValue {
                case .active: editMode?.wrappedValue = .inactive
                case .inactive: editMode?.wrappedValue = .active
                default: break
                }
            }
        } label: {
            if editMode?.wrappedValue.isEditing == true {
                Text("edit.active")
            } else {
                Text("edit.inactive")
            }
        }
    }
}

#Preview {
    CustomEditButton()
}
