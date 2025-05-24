// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/baseViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  final router = locator<AppRouter>();

  bool _isObscured = true;
  bool get isObscured => _isObscured;

  bool _isReset = true;
  bool get isReset => _isReset;

  bool _isResetConfirm = true;
  bool get isResetConfirm => _isResetConfirm;

  void toggleReset() {
    _isReset = !_isReset;
    notifyListeners();
  }

  void toggleResetConfirm() {
    _isResetConfirm = !_isResetConfirm;
    notifyListeners();
  }

  void toggleVisibility() {
    _isObscured = !_isObscured;
    notifyListeners();
  }

  void logInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      print('Function called');

      final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
      final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text(
              "Email and password cannot be empty.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            duration: const Duration(seconds: 2),
          ),
        );

        return;
      }

      if (!emailRegex.hasMatch(email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text(
              "Please enter a valid email address.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }

      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text(
              "Password must be at least 6 characters.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            duration: const Duration(seconds: 2),
          ),
        );

        return;
      }

      if (!passwordRegex.hasMatch(password)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text(
              "Use letters and numbers, min 6 characters.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final storedEmail = prefs.getString('email');
      final storedPassword = prefs.getString('password');
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      print('Stored Email: $storedEmail, Stored Password: $storedPassword');

      if (storedEmail == email && storedPassword == password) {
        if (!isLoggedIn) {
          await prefs.setBool('isLoggedIn', true);
        }

        router.replace(HomoViewRoute());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text(
              "Logged in successfully.",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: const Text(
              "Invalid email or password!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
