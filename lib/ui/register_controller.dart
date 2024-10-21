import 'dart:convert';
import 'dart:developer'; // For logging

import 'package:firebase_app/ui/api2.dart';
 // Home screen import
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP package for requests

class RegisterController {
  // Method to register user with email, password, and context
  Future<void> registerUser(
      String email, String password, BuildContext context) async {
    try {
      // Sending POST request to the registration API
      final response = await http.post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          "email": email,
          "password": password,
        },
      );

      // Logging the email and status code
      log('Response: email=$email, status=${response.statusCode}');

      // Checking if the response is successful
      if (response.statusCode == 200) {
        // Optionally parse the response body
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        log('Response Data: $responseData');

        // Navigate to Home2Screen on success
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Api2Screen()),
        );
      } else {
        // If the registration fails, display an error message
        final errorMessage = jsonDecode(response.body)['error'] ?? 'Registration failed';
        _showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      // Handling exceptions (e.g., network errors)
      log('Error: $e');
      _showErrorDialog(context, 'An error occurred. Please try again.');
    }
  }
    void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
