import 'package:in_app_update/in_app_update.dart';
import 'package:flutter/material.dart';

class UpdateService {
  /// Call this once when the app starts.
  static Future<void> checkForUpdate() async {
    try {
      final AppUpdateInfo info = await InAppUpdate.checkForUpdate();

      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        // Flexible = background download, user notified when ready
        if (info.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          await InAppUpdate.completeFlexibleUpdate();
        }
        // Immediate = fullscreen blocking update (use for critical updates)
        else if (info.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        }
      }
    } catch (e) {
      // Silently ignore — update check should never crash the app
      debugPrint('UpdateService error: $e');
    }
  }
}