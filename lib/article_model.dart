class Article {
  String title;
  String category;
  String content;
  
  Article(this.title, this.category, this.content);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'content': content
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title,
        'category': String category,
        'content': String content,
      } =>
        Article(
          title,
          category,
          content,
        ),
      _ => throw const FormatException('Failed to load article.'),
    };
  }

  get articles => null;
}