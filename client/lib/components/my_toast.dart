import 'package:flutter/material.dart';

class MyToast {
  static void show(BuildContext context, bool success, String message) {
    final Color color = success ? Colors.green : Colors.red;
    final IconData iconData = success ? Icons.check : Icons.close;
    final Color iconColor = Colors.white;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: Duration(seconds: 2), // Adjust duration as needed
        content: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.3),
              ),
              child: Icon(
                iconData,
                color: iconColor,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
