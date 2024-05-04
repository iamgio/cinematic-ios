import Foundation
import LocalAuthentication

@Observable class AuthViewModel {
    var registerUsername: String = ""
    
    var registerSuccess: Bool = false
    var loginSuccess: Bool? = nil
    
    var userExists: Bool {
        let users = try? PersistenceController.shared.container.viewContext
            .fetch(UserEntity.fetchRequest())
        
        return users?.isEmpty != true
    }
    
    func biometricsAuth() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Unlock at login."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                self.loginSuccess = success
            }
        } else {
            print("No biometrics: \(error)")
            self.loginSuccess = false
        }
    }
    
    func register() {
        if registerUsername.isEmpty {
            registerSuccess = false
            return
        }
        
        if !userExists {
            let user = UserEntity(context: PersistenceController.shared.context)
            user.name = registerUsername
            
            user.addToTrophies(Trophies.registration)
            
            PersistenceController.shared.save()
            registerSuccess = true
            loginSuccess = true
        }
    }
}
