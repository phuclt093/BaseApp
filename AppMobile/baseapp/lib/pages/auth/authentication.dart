import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Authentication {
  static Future<bool> authenticateWithBiometricsFunc() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        //biometricOnly: true,
      );
    }

    return isAuthenticated;
  }

  static Future<String> getDeviceID() async {
    String deviceId = "";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var deviceIdGet = await PlatformDeviceId.getDeviceId;
      deviceId = deviceIdGet ?? "";
    } on PlatformException {
      deviceId = '';
    }

    return deviceId;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }
}
