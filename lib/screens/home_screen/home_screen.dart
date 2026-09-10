import 'package:chatapp/core/components/app_drawer.dart';
import 'package:chatapp/core/components/user_tile.dart';
import 'package:chatapp/screens/chat_screen/chat_screen.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  //chat and auth service
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: ((context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Loading..")],
            ),
          );
        }

        //user list
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUser(userData, context))
              .toList(),
        );
      }),
    );
  }

  //build invidual list tile for user
  Widget _buildUser(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.currentUser()!.email) {
      return UserTile(
        text: userData["email"],
        //on tap -> go to chat screen
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(recieverEmail: userData["email"]);
              },
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
