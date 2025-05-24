import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/baseViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewmodel extends BaseViewModel {
  ProfileViewmodel() {
    getUserDetails();
  }

  String? username;
  String? email;
  final router = locator<AppRouter>();

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    username = prefs.getString('username');

    print(
        'Email : $email and//////////////////////////////////////////////////////////////////////////////');
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    router.replace(LoginViewRoute());
  }
}
