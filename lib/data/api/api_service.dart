import 'dart:convert';

import 'package:news_app/data/model/article.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://newsapi.org/v2/';
  static const String _apiKey = 'df98b691fe6e4550b9a9df602ca66743';
  static const String _category = 'business';
  static const String _country = 'id';

  Future<ArticlesResult> topHeadlines() async {
    final _url = Uri.parse('${_baseUrl}top-headlines?country=$_country&category=$_category&apiKey=$_apiKey');
    final response = await http.get(_url);

    if(response.statusCode == 200) {
      return ArticlesResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  } 
}