import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  // Check if biometric authentication is available
  Future<bool> isBiometricAvailable() async {
    return await _auth.canCheckBiometrics;
  }

  // Authenticate using biometric or fall back to password
  Future<bool> authenticate() async {
    try {
      // Check if biometric authentication is available
      bool canAuthenticateWithBiometrics = await isBiometricAvailable();
      
      if (canAuthenticateWithBiometrics) {
        // Authenticate using biometrics (fingerprint)
        return await _auth.authenticate(
          localizedReason: 'Scan your fingerprint ',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ),
        );
      } else {
        // If biometrics are not available, return false or show password prompt
        
        return false;
      }
    } catch (e) {
      print("Error during biometric authentication: $e");
      return false;
    }
  }
}
