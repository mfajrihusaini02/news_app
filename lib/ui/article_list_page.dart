import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:news_app/widgets/card_article.dart';
import 'package:news_app/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({Key? key}) : super(key: key);

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  late Future<ArticlesResult> _article;

  @override
  void initState() {
    super.initState();
    _article = ApiService().topHeadlines();
  }

  Widget _buildList() {
    // return FutureBuilder<String>(
    //   future: DefaultAssetBundle.of(context).loadString('assets/articles.json'),
    //   builder: (context, snapshot) {
    //     final List<Article> articles = parseArticles(snapshot.data);
    //     return ListView.builder(
    //       itemCount: articles.length,
    //       itemBuilder: (context, index) {
    //         return _buildArticleItem(context, articles[index]);
    //       },
    //     );
    //   },
    // );

    // Penggunaan API tanpa provider

    // return SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       ElevatedButton(
    //         child: const Text("Refresh Data"),
    //         onPressed: () {
    //           setState(() {
    //             _article = ApiService().topHeadlines();
    //           });
    //         },
    //       ),
    //       FutureBuilder(
    //         future: _article,
    //         builder: (context, AsyncSnapshot<ArticlesResult> snapshot) {
    //           var state = snapshot.connectionState;
    //           if (state != ConnectionState.done) {
    //             return const Center(child: CircularProgressIndicator());
    //           } else {
    //             if (snapshot.hasData) {
    //               return ListView.builder(
    //                 shrinkWrap: true,
    //                 itemCount: snapshot.data?.articles.length,
    //                 itemBuilder: (context, index) {
    //                   var article = snapshot.data?.articles[index];
    //                   return CardArticle(
    //                     article: article!,
    //                     onPressed: () {
    //                       Navigator.pushNamed(
    //                         context,
    //                         ArticleDetailPage.routeName,
    //                         arguments: article,
    //                       );
    //                     },
    //                   );
    //                 },
    //               );
    //             } else if (snapshot.hasError) {
    //               return Center(
    //                 child: Text(snapshot.error.toString()),
    //               );
    //             } else {
    //               return const Text('');
    //             }
    //           }
    //         },
    //       ),
    //     ],
    //   ),
    // );

    // Pemanggilan data API dengan Provider
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.resultState == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.resultState == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.articleResult.articles.length,
            itemBuilder: (context, index) {
              var article = state.articleResult.articles[index];
              return CardArticle(
                article: article,
                // onPressed: () {
                //   Navigator.pushNamed(
                //     context,
                //     ArticleDetailPage.routeName,
                //     arguments: article,
                //   );
                // },
              );
            },
          );
        } else if (state.resultState == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.resultState == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  // Widget _buildArticleItem(BuildContext context, Article article) {
  //   return Material(
  //     child: ListTile(
  //       contentPadding: const EdgeInsets.symmetric(
  //         horizontal: 16,
  //         vertical: 8,
  //       ),
  //       leading: Hero(
  //         tag: article.urlToImage,
  //         child: Image.network(
  //           article.urlToImage,
  //           width: 100,
  //         ),
  //       ),
  //       title: Text(article.title),
  //       subtitle: Text(article.author),
  //       onTap: () {
  //         Navigator.pushNamed(
  //           context,
  //           ArticleDetailPage.routeName,
  //           arguments: article,
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('News App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
