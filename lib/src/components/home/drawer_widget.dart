import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://backgrounddownload.com/wp-content/uploads/2018/09/android-navigation-drawer-background-image-1.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            accountEmail: Text(""),
            accountName: Text(
              "",
              // serverController.loggedUser.nickname,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              // backgroundImage: FileImage(serverController.loggedUser.photo),
              backgroundColor: Colors.grey[100],
            ),
            onDetailsPressed: () {
              // Navigator.pop(context);
              // Navigator.of(context).pushNamed(
              //   "/register",
              //   arguments: serverController.loggedUser,
              // );
            },
          ),
          ListTile(
            title: Text(
              "Mis recetas",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            leading: Icon(
              Icons.book,
              color: Colors.green,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Mis favoritos",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.of(context).pushNamed(
              //   '/favorites',
              //   arguments: serverController.loggedUser,
              // );
            },
          ),
          ListTile(
            title: Text(
              "Cerrar sesión",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.blue,
            ),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    // await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/");
  }
}
