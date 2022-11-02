import 'package:flutter/cupertino.dart';
import 'package:news_app/data/api/api_service.dart';
import 'package:news_app/data/model/article.dart';

enum ResultState { Loading, NoData, HasData, Error }

class NewsProvider extends ChangeNotifier {
  final ApiService apiService;

  NewsProvider({required this.apiService}) {
    _fetchArticle();
  }

  late ArticlesResult _articleResult;
  late ResultState _resultState;
  String _message = '';

  String get message => _message;

  ArticlesResult get articleResult => _articleResult;

  ResultState get resultState => _resultState;

  Future<dynamic> _fetchArticle() async {
    try {
      _resultState = ResultState.Loading;
      notifyListeners();
      final article = await apiService.topHeadlines();

      if (article.articles.isEmpty) {
        _resultState = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _resultState = ResultState.HasData;
        notifyListeners();
        return _articleResult = article;
      }
    } catch (e) {
      _resultState = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
