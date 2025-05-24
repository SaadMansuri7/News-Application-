import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/views/signup/signup_viewModel.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SignupViewScreen extends StatelessWidget {
  SignupViewScreen({Key? key}) : super(key: key);

  final TextEditingController cnt1 = TextEditingController();
  final TextEditingController cnt2 = TextEditingController();
  final TextEditingController cnt3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignupViewModel(),
      builder: (context, _) {
        final model = context.watch<SignupViewModel>();
        final router = locator<AppRouter>();
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Username',
                                style: GoogleFonts.lato(fontSize: 12),
                              ),
                              Text(
                                '*',
                                style: GoogleFonts.lato(
                                    fontSize: 12, color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: cnt3,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                'Email',
                                style: GoogleFonts.lato(fontSize: 12),
                              ),
                              Text(
                                '*',
                                style: GoogleFonts.lato(
                                    fontSize: 12, color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: cnt1,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Password',
                                style: GoogleFonts.lato(fontSize: 12),
                              ),
                              Text(
                                '*',
                                style: GoogleFonts.lato(
                                    fontSize: 12, color: Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: cnt2,
                                obscureText: model.isObscured,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 16),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        model.isObscured
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey),
                                    onPressed: () {
                                      model.toggleVisibility();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            model.signUpWithEmail(
                                context, cnt1.text, cnt2.text, cnt3.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Signup',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: InkWell(
                          onTap: () {
                            router.replace(LoginViewRoute());
                          },
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.lato(
                                  color: Colors.black87, fontSize: 14),
                              children: [
                                const TextSpan(
                                    text: "Already have an account? "),
                                TextSpan(
                                  text: 'Login',
                                  style: GoogleFonts.lato(color: Colors.blue),
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
