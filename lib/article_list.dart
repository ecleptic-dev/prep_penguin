import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prepping_penguin/article_detail.dart';
import 'package:prepping_penguin/article_model.dart';
import 'package:http/http.dart' as http;

class ArticleList extends StatelessWidget {
  const ArticleList({super.key, required String title, required String category, required String content});
  
  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder<List<Article>>(
  future: fetchArticles(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      
      return ListView.builder(
      //shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(snapshot.data![index].title),
          subtitle: Text(snapshot.data![index].category),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetail(article: snapshot.data![index]),
          ),
        );
          }
        );
      },
    );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return Container(
        width: 24,
        height: 24,
        child: const CircularProgressIndicator(
        color: Colors.blue,
        strokeWidth: 2.0,
        semanticsLabel: 'Getting Articles...'
      ),
    );
  },
);  
}

Future<List<Article>> fetchArticles() async {
  final response = await http
      .get(Uri.parse('https://preppy-penguin-82.hasura.app/api/rest/articles'),
      headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    'x-hasura-admin-secret': 'c37jorD1se6E9chhEXSITbgpO5qDoWlbJdQ0kkKcyZGEmo6M8jwqiWBgAqKtOXvK'
  },);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Article> list = [];
    debugPrint(response.body);
    
    for (var i = 0; i < jsonDecode(response.body)['articles'].length; i++) {
      list.add(Article.fromJson(jsonDecode(response.body)['articles'][i]));
    }
    return list; 
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

}