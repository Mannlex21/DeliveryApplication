import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  final BuildContext context;
  const EditProfileScreen(this.context, {Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          iconSize: 30,
          padding: const EdgeInsets.only(left: 25),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: const Text(
          'Edit Account',
          style: TextStyle(color: Colors.black),
        ),
        flexibleSpace: Container(),
        toolbarHeight: 70,
        elevation: 0,
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeLeft: true,
        child: Container(
          width: double.infinity,
          color: const Color(0xFFF6F6F6),
          child: Column(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              textForm('Name', 'Manuel Alejandro', false),
              textForm('Last Name', 'Murillo Macias', false),
              textForm('Phone Number', '+52 311 123 4567', true),
              textForm('Email', 'correo@mail.com', true),
              textForm('Password', '******', true),
            ],
          ),
        ),
      ),
    );
  }

  Widget textForm(String label, String value, bool editable) {
    return GestureDetector(
      onTap: editable ? () => {} : null,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
              color: Color(0xFFF6F6F6),
              width: 1,
            ))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(
                    color: editable ? Colors.black : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: editable ? Colors.black : Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Icon(
                    editable ? Icons.arrow_forward_ios : null,
                    color: Colors.green,
                    size: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
