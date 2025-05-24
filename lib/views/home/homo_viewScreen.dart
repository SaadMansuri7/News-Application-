import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:newsapp/app_locator.dart';
import 'package:newsapp/app_router.dart';
import 'package:newsapp/app_router.gr.dart';
import 'package:newsapp/model/article.dart';
import 'package:newsapp/views/home/home_viewModel.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeViewScreen extends StatelessWidget {
  final int initialIndex;

  HomeViewScreen({super.key, this.initialIndex = 0});
  final TextEditingController searchCnt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Builder(builder: (context) {
        final router = locator<AppRouter>();
        final model = context.watch<HomeViewModel>();
        final TabController tabController = DefaultTabController.of(context);

        tabController.addListener(() {
          if (!tabController.indexIsChanging && tabController.index == 1) {
            model.getAllBookmarkedArticles();
          }
        });

        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: searchCnt,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Search for News',
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(48, 14, 14, 14),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onChanged: (value) =>
                                  model.giveSuggestions(value),
                              onSubmitted: (value) {
                                model.getArticlesByKeywords(value);
                                searchCnt.clear();
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Icon(Icons.search, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: () {
                          router.push(ProfileViewRoute());
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/image.png',
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (model.suggestions.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(blurRadius: 4, color: Colors.black12),
                          ],
                        ),
                        child: ListView.builder(
                          itemCount: model.suggestions.length,
                          itemBuilder: (context, index) {
                            final suggestion = model.suggestions[index];
                            return ListTile(
                              title: Text(suggestion),
                              onTap: () {
                                router
                                    .push(SearchResultRoute(value: suggestion));
                                model.suggestions.clear();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                    ),
                    child: const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.blue,
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(text: 'NEWS'),
                        Tab(text: 'BOOKMARK'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          await model.refreshArticles(
                              loadMore: true, context: context);
                          MotionToast.success(
                              title: Text('Success'),
                              description: Text(
                                'Articles refreshed',
                                style: GoogleFonts.lato(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: ListView.builder(
                            itemCount: model.articles.length + 1,
                            itemBuilder: (context, index) {
                              if (index < model.articles.length) {
                                final article = model.articles[index];
                                return InkWell(
                                  onTap: () {
                                    router.push(
                                        DetailsViewRoute(link: article.link));
                                  },
                                  child: newsCard(context,
                                      article: article!, model: model),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: model.isLoad
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.blue.shade600,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            model.fetchArticles(loadMore: true);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            child: Text(
                                              'Load More News',
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      model.bookmarkedArticles.isEmpty
                          ? Center(
                              child: Text(
                                'No bookmarks yet.',
                                style: GoogleFonts.lato(
                                    color: Colors.grey, fontSize: 16),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              child: ListView.builder(
                                itemCount: model.bookmarkedArticles.length,
                                itemBuilder: (context, index) {
                                  final article =
                                      model.bookmarkedArticles[index];
                                  return InkWell(
                                    onTap: () {
                                      router.push(
                                          DetailsViewRoute(link: article.link));
                                    },
                                    child: newsCard(context,
                                        article: article, model: model),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  static Widget newsCard(BuildContext context,
      {required Articles article, required HomeViewModel model}) {
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
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/news.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
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
                          color: Colors.grey[600], fontSize: 13),
                    ),
                    IconButton(
                      onPressed: () {
                        model.toggleBookmark(article, context);
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
