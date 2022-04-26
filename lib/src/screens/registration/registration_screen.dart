import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../models/response.dart';
import '../../components/utils/display_dialog_widget.dart';

class RegistrationScreen extends StatefulWidget {
  final BuildContext context;
  const RegistrationScreen(this.context, {Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _areaCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String firstName = "";
  String lastName = "";
  String username = "";
  String email = "";
  String password = "";
  String areaCode = "";
  String phoneNumber = "";
  String errorMessage = "";
  bool showPassword = false;

  late FocusNode firstNameFocus;
  late FocusNode lastNameFocus;
  late FocusNode usernameFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode areaCodeFocus;
  late FocusNode phoneNumberFocus;
  late FocusNode registerBtnFocus;

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
          children: [
            Expanded(
              child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(15.0),
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
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: "First Name"),
                                      controller: _firstNameController,
                                      focusNode: firstNameFocus,
                                      keyboardType: TextInputType.name,
                                      onEditingComplete: () =>
                                          requestFocus(context, lastNameFocus),
                                      textInputAction: TextInputAction.next,
                                      onSaved: (value) {
                                        firstName = value!;
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
                                          labelText: "Last Name"),
                                      controller: _lastNameController,
                                      focusNode: lastNameFocus,
                                      keyboardType: TextInputType.name,
                                      onEditingComplete: () =>
                                          requestFocus(context, usernameFocus),
                                      textInputAction: TextInputAction.next,
                                      onSaved: (value) {
                                        lastName = value!;
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
                                          labelText: "Username"),
                                      controller: _usernameController,
                                      focusNode: usernameFocus,
                                      keyboardType: TextInputType.name,
                                      onEditingComplete: () =>
                                          requestFocus(context, emailFocus),
                                      textInputAction: TextInputAction.next,
                                      onSaved: (value) {
                                        username = value!;
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
                                          labelText: "Email"),
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
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Password",
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
                                      onEditingComplete: () => requestFocus(
                                          context, phoneNumberFocus),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 50,
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                labelText: "Lada"),
                                            controller: _areaCodeController,
                                            focusNode: areaCodeFocus,
                                            keyboardType: TextInputType.phone,
                                            onEditingComplete: () =>
                                                requestFocus(
                                                    context, phoneNumberFocus),
                                            textInputAction:
                                                TextInputAction.next,
                                            onSaved: (value) {
                                              areaCode = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Este campo es obligatorio";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                labelText: "Phone Number"),
                                            controller: _phoneNumberController,
                                            focusNode: phoneNumberFocus,
                                            keyboardType: TextInputType.phone,
                                            onEditingComplete: () =>
                                                requestFocus(
                                                    context, registerBtnFocus),
                                            textInputAction:
                                                TextInputAction.next,
                                            onSaved: (value) {
                                              phoneNumber = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Este campo es obligatorio";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      focusNode: registerBtnFocus,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                        backgroundColor:
                                            MaterialStateProperty.all(
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _areaCodeController.dispose();
    _phoneNumberController.dispose();

    firstNameFocus.dispose();
    lastNameFocus.dispose();
    usernameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    areaCodeFocus.dispose();
    phoneNumberFocus.dispose();
    registerBtnFocus.dispose();
  }

  @override
  void initState() {
    super.initState();
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    usernameFocus = FocusNode();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    areaCodeFocus = FocusNode();
    phoneNumberFocus = FocusNode();
    registerBtnFocus = FocusNode();
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
          Uri.parse('http://127.0.0.1:8000/client/signUp'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
            {
              'user': {
                'username': _usernameController.text,
                'password': _passwordController.text,
                'email': _emailController.text
              },
              'user_details': {
                'firstName': _firstNameController.text,
                'lastName': _lastNameController.text,
                'areaCode': _areaCodeController.text,
                'phoneNumber': _phoneNumberController.text
              }
            },
          ),
        );

        var result = Response.fromJson(jsonDecode(request.body.toString()));
        if (result.success) {
          Navigator.of(context).pushNamed('/login');
        } else {
          displayDialog(context, "Error", "${result.errorList?.first.message}");
        }
      }
    } catch (e) {
      displayDialog(context, "An Error Occurred", "Error");
    }
  }
}
