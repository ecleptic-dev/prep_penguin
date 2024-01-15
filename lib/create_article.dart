import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prepping_penguin/article_list.dart';
import 'package:prepping_penguin/article_list_page.dart';
import 'package:prepping_penguin/inventory.dart';
import 'package:prepping_penguin/main.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

//TODO implement admin claims
class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({super.key});

  @override
  CreateArticleState createState() {
    return CreateArticleState();
  }
}

class CreateArticleState extends State<CreateArticlePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String category = '';
  String content = '';
  final controllerTitle = TextEditingController();
  final controllerCategory = TextEditingController();
  final controllerContent = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerTitle.dispose();
    controllerCategory.dispose();
    controllerContent.dispose();
    super.dispose();
  }

_onSubmit() async {
  setState(() => loading = true);

  if (_formKey.currentState!.validate()) {
   // If the form is valid, display a snackbar. In the real world,
   // you'd often call a server or save the information in a database.
   var res = await createArticle(controllerTitle.text, controllerCategory.text, controllerContent.text);
   if (res.statusCode == 200) {
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ArticleListPage()));
  } 
  }
}

Future<http.Response> createArticle(String title, String category, String content) async {
  var articleDto = {
    "title": title,
    "category": category,
    "content": content
  };

  final response = await http.post(
    Uri.parse('https://preppy-penguin-82.hasura.app/api/rest/articles'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      'x-hasura-admin-secret': 'c37jorD1se6E9chhEXSITbgpO5qDoWlbJdQ0kkKcyZGEmo6M8jwqiWBgAqKtOXvK'
    },
    body: jsonEncode(articleDto),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    debugPrint('good response');
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    return response;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    debugPrint(response.reasonPhrase);

    debugPrint(response.body);
    debugPrint(response.statusCode.toString());
    debugPrint(response.request!.url.toString());
    throw Exception('Failed to create article');
  }
}

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Form(
      key: _formKey,
      child: Consumer<AppModel>(builder: (context, value, child) =>  SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: controllerTitle,
              decoration: const InputDecoration(labelText: 'Title'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controllerCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Category';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controllerContent,
              decoration: const InputDecoration(labelText: 'Content'),
              keyboardType: TextInputType.multiline,
              maxLines: 500,
              minLines: 1,
              maxLength: 35000,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Content';
                }
                return null;
              }
            ),
            //RichTextEditor(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: 
              ElevatedButton.icon(
                onPressed: loading ? null : _onSubmit,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
                icon: loading ? Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(2.0),
                  child: const CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 3,
                  ),
                ) : const Icon(Icons.feedback),
                label: const Text('Save'),
            ),
            ),
          ],
        ),
      ),
    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

