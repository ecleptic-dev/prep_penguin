import 'package:flutter/material.dart';
import 'package:prepping_penguin/article_model.dart';

class ArticleDetail extends StatelessWidget {
  // In the constructor, require a Todo.
  const ArticleDetail({super.key, required this.article});

  // Declare a field that holds the Todo.
  final Article article;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ListView(
            children: [
              Text(article.category,
                style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: article.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}