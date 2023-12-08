import 'package:flutter/material.dart';
import 'package:prepping_penguin/main.dart';
import 'package:provider/provider.dart';

// Define a custom Form widget.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginState createState() {
    return LoginState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class LoginState extends State<LoginPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  final controllerUser = TextEditingController();
  final controllerPass = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controllerUser.dispose();
    controllerPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Consumer<AppModel>(builder: (context, value, child) =>  SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: controllerUser,
              decoration: const InputDecoration(labelText: 'User Name'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your login';
                }
                return null;
              },
            ),
            TextFormField(
              controller: controllerPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    setState(() {
                      username = controllerUser.text;
                      password = controllerPass.text;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content:
                        Row(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text("     Logging In...")
                        ],
                        ),
                      )
                    );
                    value.setLogin(true);
                    ScaffoldMessenger.of(context).clearSnackBars();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}