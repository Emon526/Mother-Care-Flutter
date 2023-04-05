class ArticleModel {
  int articleId;
  String articleTitle;
  String articleDescription;
  String articleImage;

  ArticleModel({
    required this.articleId,
    required this.articleTitle,
    required this.articleDescription,
    required this.articleImage,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      articleId: map['articleId'],
      articleTitle: map['articleTitle'],
      articleDescription: map['articleDescription'],
      articleImage: map['articleImage'],
    );
  }
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'userid': userid,
  //     'title': title,
  //     'content': content,
  //     'dateAdded': dateAdded!.toIso8601String()
  //   };
  // }
}
