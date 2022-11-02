// import 'dart:convert';

// class Article {
//   late String author;
//   late String title;
//   late String description;
//   late String url;
//   late String urlToImage;
//   late String publishedAt;
//   late String content;

//   Article({
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.url,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.content,
//   });

//   Article.fromJSON(Map<String, dynamic> article) {
//     author = article['author'];
//     title = article['title'];
//     description = article['description'];
//     url = article['url'];
//     urlToImage = article['urlToImage'];
//     publishedAt = article['publishedAt'];
//     content = article['content'];
//   }
// }
// List<Article> parseArticles(String? json) {
//   if (json == null) {
//     return [];
//   }

//   final List parsed = jsonDecode(json);
//   return parsed.map((e) => Article.fromJSON(e)).toList();
// }

// Menggunakan data dari API

class ArticlesResult {
  ArticlesResult({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  String status;
  int totalResults;
  List<Article> articles;

  factory ArticlesResult.fromJson(Map<String, dynamic> json) {
    return ArticlesResult(
      status: json["status"],
      totalResults: json["totalResults"],
      articles: List<Article>.from(
        (json["articles"] as List).map((x) => Article.fromJson(x)).where(
              (element) =>
                  element.author != null &&
                  element.urlToImage != null &&
                  element.publishedAt != null &&
                  element.content != null,
            ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json["author"],
      title: json["title"],
      description: json["description"],
      url: json["url"],
      urlToImage: json["urlToImage"],
      publishedAt: DateTime.parse(json["publishedAt"]),
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };
}
