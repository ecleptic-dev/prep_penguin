import 'package:flutter/material.dart';
import 'package:prepping_penguin/main.dart';
import 'package:prepping_penguin/rich_text_editor.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerTitle.dispose();
    controllerCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Article'),
      ),
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
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Category'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Category';
                }
                return null;
              },
            ),
            RichTextEditor(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    setState(() {
                      title = controllerTitle.text;
                      category = controllerCategory.text;
                      content = RichTextEditor().getJsonDocument();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content:
                        Row(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text("     Creating article...")
                        ],
                        ),
                      )
                    );
                    ScaffoldMessenger.of(context).clearSnackBars();
                  }
                },
                child: const Text('Create Article'),
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
