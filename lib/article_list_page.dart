import 'package:flutter/material.dart';
import 'package:prepping_penguin/article_list.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});
  
  @override
  ArticleState createState() {
    return ArticleState();
  }
}

class ArticleState extends State<ArticleListPage> {

  String title = 'Test Title';
  String category = 'test category';
  String content = 'test content';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ArticleList(
                  title: title,
                  category: category,
                  content: content
                ),
    );
  }

}