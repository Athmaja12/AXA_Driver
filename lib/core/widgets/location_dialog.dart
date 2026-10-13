import 'package:flutter/material.dart';

Future<bool> showLocationDisclosure(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text("Location Access Required"),
          content: const SingleChildScrollView(
            child: Text(
              "AXA Driver collects location data to:\n\n"
              "• Assign nearby deliveries\n"
              "• Track active delivery routes\n"
              "• Verify delivery completion\n"
              "• Provide live driver tracking\n\n"
              "Location data may be collected while the app is in use and while running in the background when you are on duty.\n\n"
              "Your location is used only for delivery operations.",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Not Now"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Continue"),
            ),
          ],
        ),
      ) ??
      false;
}