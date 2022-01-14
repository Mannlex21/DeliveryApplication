import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final BuildContext context;
  LoginScreen(this.context, {Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String email = "";
  String password = "";
  String errorMessage = "";
  bool showPassword = false;

  late FocusNode emailFocus;
  late FocusNode passwordFocus;

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
                    Text(
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
                          TextFormField(
                            decoration: InputDecoration(labelText: "Usuario:"),
                            controller: _emailController,
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
                          SizedBox(
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
                            onEditingComplete: () => _login(context),
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
                          SizedBox(
                            height: 15,
                          ),
                          if (errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Iniciar Sesión'),
                              ],
                            ),
                            onPressed: () => _login(context),
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(15)),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("¿No estas registrado?"),
                              TextButton(
                                style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                child: Text("Registrarse"),
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
    this._emailController.dispose();
    this._passwordController.dispose();

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

  Future<void> _login(BuildContext context) async {
    // try {
    //   FocusScope.of(context).unfocus();
    //   if (_formKey.currentState.validate()) {
    //     setState(() {
    //       errorMessage = "";
    //     });

    //     UserCredential userCredential =
    //         await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: _emailController.text,
    //       password: _passwordController.text,
    //     );

    //     if (userCredential != null) {
    //       Navigator.of(context).pushReplacementNamed('/home');
    //     }
    //   }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     setState(() {
    //       errorMessage = "No user found for that email.";
    //     });
    //   } else if (e.code == 'wrong-password') {
    //     setState(() {
    //       errorMessage = "Wrong password provided for that user.";
    //     });
    //   }
    // }
  }
}
