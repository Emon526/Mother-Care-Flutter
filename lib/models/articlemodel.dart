class ArticleModel {
  int articleId;
  String articleTitle;
  String articleDescription;
  String? articleImage;

  ArticleModel({
    required this.articleId,
    required this.articleTitle,
    required this.articleDescription,
    this.articleImage,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      articleId: int.parse(map['articleId']),
      articleTitle: map['articleTitle'],
      articleDescription: map['articleDescription'],
      articleImage: map['articleImage'],
    );
  }
}
