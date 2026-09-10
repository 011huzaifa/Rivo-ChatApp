import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void logout() {
    final auth = AuthService();

    //logout
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                child: Icon(
                  Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 5),
                child: ListTile(
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 5),
                child: ListTile(
                  title: Text("Settings"),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SettingsScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 5),
            child: ListTile(
              title: Text("Logout"),
              leading: Icon(Icons.logout),
              onTap: () => logout(),
            ),
          ),
        ],
      ),
    );
  }
}
