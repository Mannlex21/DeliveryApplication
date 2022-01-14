import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  final BuildContext context;
  RegistrationScreen(this.context, {Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: const Color(0xFFF9F9F9),
        elevation: 0,
      ),
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
                            decoration: InputDecoration(labelText: "Email:"),
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
                            height: 20,
                          ),
                          ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Registrar'),
                              ],
                            ),
                            onPressed: () => _registration(context),
                            style: ButtonStyle(
                              textStyle: MaterialStateProperty.all(
                                TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 15)),
                            ),
                          ),
                          SizedBox(
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

  void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  Future<void> _registration(BuildContext context) async {
    // try {
    //   if (_formKey.currentState.validate()) {
    //     setState(() {
    //       errorMessage = "";
    //     });

    //     UserCredential userCredential =
    //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: _emailController.text,
    //       password: _passwordController.text,
    //     );

    //     if (userCredential != null) {
    //       Navigator.of(context).pushNamed('/login');
    //     }
    //   }
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }
}
