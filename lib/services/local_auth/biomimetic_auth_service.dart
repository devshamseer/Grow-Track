import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class Biometricauth {
  // The LocalAuthentication instance is static so it can be accessed directly
  static final LocalAuthentication auth = LocalAuthentication();

  // Static method to check and perform biometric authentication
  static Future<void> checkBiometric() async {
    bool canCheckBiometric = await auth.canCheckBiometrics;  // Check if biometric authentication is possible on the device

    if (canCheckBiometric) {
      List<BiometricType> availableBiometric = await auth.getAvailableBiometrics();  // Get the available biometric types on the device

      if (availableBiometric.isNotEmpty) {
        try {
          // Perform biometric authentication with stickyAuth to prevent dismiss
          bool authenticated = await auth.authenticate(
           
            localizedReason: "Hello Test",  // Message shown to the user
            options: const AuthenticationOptions(
              stickyAuth: true,  // Keep the authentication window active until authentication is completed
              useErrorDialogs: true,  // Show error dialogs if authentication fails
              biometricOnly: true,  // Only use biometrics, no fallback method (e.g., PIN)
            ),
          );

          // Log the authentication result
          if (authenticated) {
            print("Authentication successful!");  // Success log
          } else {
            print("Authentication failed!");  // Failure log
          }
        } catch (e) {
          // Catch any errors or cancellation
          print("Authentication process was canceled or failed with error: $e");
        }
      } else {
        print("No available biometrics found!");  // Log when no biometrics are available on the device
      }
    } else {
      print("Biometric authentication is not supported on this device!");  // Log if biometrics are not supported
    }
  }
}