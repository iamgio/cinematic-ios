import Foundation
import LocalAuthentication

@Observable class AuthViewModel {
    var loginSuccess: Bool? = nil
    
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
}
