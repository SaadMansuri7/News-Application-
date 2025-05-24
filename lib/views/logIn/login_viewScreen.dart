import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/views/logIn/login_viewModel.dart';
import 'package:provider/provider.dart';

@RoutePage()
class LoginViewScreen extends StatelessWidget {
  LoginViewScreen({Key? key}) : super(key: key);

  final TextEditingController cnt1 = TextEditingController();
  final TextEditingController cnt2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouter>();

    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      builder: (context, _) {
        final model = context.watch<LoginViewModel>();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 32,
                  right: 32,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  top: 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello',
                            style: GoogleFonts.lato(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Again!',
                            style: GoogleFonts.lato(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Welcome back you've been missed",
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Email',
                        style: GoogleFonts.lato(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: cnt1,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Password',
                        style: GoogleFonts.lato(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: cnt2,
                        obscureText: model.isObscured,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              model.isObscured
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              if (cnt2.text.isNotEmpty) {
                                model.toggleVisibility();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            model.logInWithEmail(context, cnt1.text, cnt2.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: InkWell(
                          onTap: () {
                            router.replace(SignupViewRoute());
                          },
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.lato(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                              children: const [
                                TextSpan(text: "Don't have an account? "),
                                TextSpan(
                                  text: 'Sign up',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
