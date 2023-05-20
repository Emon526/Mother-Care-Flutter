import 'dart:convert';

class ArticleModel {
  int articleId;
  dynamic articleTitle;
  dynamic articleDescription;
  String? articleImage;

  ArticleModel({
    required this.articleId,
    required this.articleTitle,
    required this.articleDescription,
    this.articleImage,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    final decodedTitle = json.decode(map['articleTitle']);
    final decodedDescription = json.decode(map['articleDescription']);
    return ArticleModel(
      articleId: int.parse(map['articleId']),
      articleTitle: decodedTitle,
      articleDescription: decodedDescription,
      articleImage: map['articleImage'],
    );
  }
}
