import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/views/profile/profile_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class ProfileViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewmodel(),
      builder: (context, _) {
        final model = context.watch<ProfileViewmodel>();
        final router = locator<AppRouter>();
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            title: Text(
              'Profile',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image.png',
                  height: 58,
                  width: 58,
                ),
                const SizedBox(height: 20),
                Text(
                  model.username ?? 'Unkown',
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  model.email ?? '',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  leading: const Icon(Icons.bookmark, color: Colors.blue),
                  title: Text('Bookmarks',
                      style: GoogleFonts.lato(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    router.push(HomoViewRoute(initialIndex: 1));
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text('Logout',
                      style: GoogleFonts.lato(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    model.logout();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
