import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  final BuildContext context;
  const RegistrationScreen(this.context, {Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String name = "";
  String user = "";
  String email = "";
  String password = "";
  String errorMessage = "";
  bool showPassword = false;

  late FocusNode nameFocus;
  late FocusNode userFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 35, left: 35, bottom: 10, top: 0),
                    child: Center(
                      child: Column(
                        children: [
                          const Text(
                            "Registration",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: "User:"),
                                  controller: _userController,
                                  focusNode: userFocus,
                                  keyboardType: TextInputType.name,
                                  onEditingComplete: () =>
                                      requestFocus(context, passwordFocus),
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo es obligatorio";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Email:"),
                                  controller: _emailController,
                                  focusNode: emailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  onEditingComplete: () =>
                                      requestFocus(context, passwordFocus),
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo es obligatorio";
                                    }

                                    bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value);

                                    if (!emailValid) {
                                      return "Ingrese un email valido";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Contraseña:",
                                    suffixIcon: IconButton(
                                      icon: Icon(showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          showPassword = !showPassword;
                                        });
                                      },
                                    ),
                                  ),
                                  obscureText: !showPassword,
                                  controller: _passwordController,
                                  focusNode: passwordFocus,
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Este campo es obligatorio";
                                    }

                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('Registrar'),
                                    ],
                                  ),
                                  onPressed: () => _registration(context),
                                  style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 15)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    nameFocus.dispose();
    userFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameFocus = FocusNode();
    userFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> _registration(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          errorMessage = "";
        });

        var request = await http.post(
          Uri.parse('http://192.168.1.64:9090/client/signUp'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            'id': 0,
            'user': _userController.text.toLowerCase(),
            'password': _passwordController.text,
            'email': _emailController.text
          }),
        );

        if (request.body == 'true') {
          Navigator.of(context).pushNamed('/login');
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
