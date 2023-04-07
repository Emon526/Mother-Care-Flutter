import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/articlemodel.dart';
import '../services/breastcancerapiservice.dart';
import '../utils/exception_hander.dart';

class BreastCancerProvider extends ChangeNotifier {
  List<ArticleModel> _articlesList = [];
  List<ArticleModel> get articles => _articlesList;

  Future<List<ArticleModel>> articlesList() async {
    try {
      _articlesList = [];
      var response = await BreastCancerApiService.articleslist();
      var articleList = jsonDecode(response.body)['articles'];
      for (var article in articleList) {
        ArticleModel newArticle = ArticleModel.fromMap(article);
        _articlesList.add(newArticle);
      }

      sortArticles();
    } catch (e) {
      throw ExceptionHandlers.getExceptionString(e);
    }

    return _articlesList;
  }

  void sortArticles() {
    _articlesList.sort((a, b) {
      var firstdata = a.articleId;
      var lastdata = b.articleId;
      return firstdata.compareTo(lastdata);
    });
  }

  Future<Uint8List?> getArticleImage(String imagebyte) async {
    return base64Decode(imagebyte);
  }

  refresh() async {
    _articlesList = await articlesList();
    notifyListeners();
  }
}
