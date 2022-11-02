import 'package:flutter/material.dart';
import 'package:news_app/common/navigation.dart';
import 'package:news_app/data/model/article.dart';
import 'package:news_app/common/styles.dart';
import 'package:news_app/provider/database_provider.dart';
import 'package:news_app/ui/article_detail_page.dart';
import 'package:provider/provider.dart';

class CardArticle extends StatelessWidget {
  final Article article;
  // final Function() onPressed;
  const CardArticle({
    Key? key,
    required this.article,
    // required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        return FutureBuilder<bool>(
          future: state.isBookmarked(article.url),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            print(isBookmarked);
            return Material(
              // color: primaryColor,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                leading: Hero(
                  tag: article.urlToImage!,
                  child: Image.network(
                    article.urlToImage!,
                    width: 100,
                  ),
                ),
                trailing: isBookmarked
                    ? IconButton(
                        icon: const Icon(Icons.bookmark),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => state.removeBookmark(article.url),
                      )
                    : IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => state.addBookmark(article),
                      ),
                title: Text(article.title),
                subtitle: Text(article.author!),
                // onTap: () {
                //   Navigator.pushNamed(
                //     context,
                //     ArticleDetailPage.routeName,
                //     arguments: article,
                //   );
                // },
                onTap: () {
                  Navigation.intentWithData(
                      ArticleDetailPage.routeName, article);
                },
              ),
            );
          },
        );
      },
    );
  }
}
