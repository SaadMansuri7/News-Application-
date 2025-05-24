import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/search/search_viewModel.dart';
import 'package:provider/provider.dart';

@RoutePage()
class SearchResultScreen extends StatelessWidget {
  final String value;
  const SearchResultScreen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
      builder: (context, _) {
        final model = context.watch<SearchViewModel>();
        final router = locator<AppRouter>();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!model.isLoad && model.filterdarticles.isEmpty) {
            model.getArticlesByKeywords(value);
          }
        });
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.5,
            title: Text(
              value,
              style: GoogleFonts.roboto(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
            child: model.isLoad && model.filterdarticles.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : model.filterdarticles.isEmpty
                    ? Center(
                        child: Text(
                          'No results found for "$value"',
                          style: GoogleFonts.lato(
                              fontSize: 16, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: ListView.builder(
                          itemCount: model.filterdarticles.length,
                          itemBuilder: (context, index) {
                            final article = model.filterdarticles[index];
                            return InkWell(
                              onTap: () => router
                                  .push(DetailsViewRoute(link: article.link)),
                              child: newsCard(context,
                                  article: article!, model: model),
                            );
                          },
                        ),
                      ),
          ),
        );
      },
    );
  }

  static Widget newsCard(BuildContext context,
      {required Articles article, required SearchViewModel model}) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
              article.image_url ??
                  'https://via.placeholder.com/300x180.png?text=No+Image+Available',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/news.jpg',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          }),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat('d MMMM, y')
                            .format(article.pubDate ?? DateTime.now()),
                        style: GoogleFonts.lato(
                            color: Colors.grey[600], fontSize: 13)),
                    IconButton(
                      onPressed: () {
                        model.toggleBookmark(article);
                      },
                      icon: Icon(
                        model.bookmarkedArticles
                                .any((a) => a.article_id == article.article_id)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: model.bookmarkedArticles
                                .any((a) => a.article_id == article.article_id)
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
