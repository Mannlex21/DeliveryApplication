import 'dart:convert';
import 'dart:io';

import 'package:delivery_application/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  final BuildContext context;
  const LoginScreen(this.context, {Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailOrUserController = TextEditingController();
  final _passwordController = TextEditingController();

  String email = "";
  String password = "";
  String errorMessage = "";
  bool showPassword = false;

  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  List<User> listOfUsers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 35, left: 35, bottom: 10, top: 20),
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // imgFuture(),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Usuario:"),
                            controller: _emailOrUserController,
                            focusNode: emailFocus,
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
                            onEditingComplete: () => _signIn(context),
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
                            height: 15,
                          ),
                          if (errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                errorMessage,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('Iniciar Sesión'),
                              ],
                            ),
                            onPressed: () => _signIn(context),
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(15)),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("¿No estas registrado?"),
                              TextButton(
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                child: const Text("Registrarse"),
                                onPressed: () => _showRegister(context),
                              )
                            ],
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailOrUserController.dispose();
    _passwordController.dispose();

    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/registration');
  }

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> _signIn(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        errorMessage = "";
      });

      var request = await http.post(
        Uri.parse('http://192.168.1.64:9090/client/signIn'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'emailOrUser': _emailOrUserController.text,
          'password': _passwordController.text
        }),
      );

      if (request.body == 'true') {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
    // print(request.body == 'true' ? 'entro' : 'no permitido');
    // List<dynamic> listUsers = jsonDecode(request.body.toString());
    // listOfUsers = listUsers.map((e) => User.fromJson(e)).toList();
    // print(listOfUsers[0].user);
  }

  Future<dynamic> downloadData() async {
    var request = await http.get(Uri.parse('http://192.168.1.64:9090/getImg'));
    return jsonDecode(request.body.toString());
  }

  Future<Widget> img(String data) async {
    var r = jsonDecode(data);
    if (r['result'] == '') {
      return Container();
    }

    final decodedBytes = base64Decode(r['result']);
    var fileImg = File("testImage.png");
    fileImg.writeAsBytesSync(decodedBytes);
    return Image.file(fileImg);
  }

  Widget imgFuture() {
    return FutureBuilder<dynamic>(
      future: downloadData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasError) {
            return Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage("assets/image/default-image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            final decodedBytes = base64Decode(snapshot.data['result']);
            return Center(
              child: Image.memory(
                decodedBytes,
                gaplessPlayback: true,
              ),
            );
          }
        }
      },
    );
  }
}
