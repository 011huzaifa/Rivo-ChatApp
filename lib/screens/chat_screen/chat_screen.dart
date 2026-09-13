import 'package:chatapp/core/components/app_textfield.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:chatapp/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;
  ChatScreen({
    super.key,
    required this.recieverEmail,
    required this.recieverID,
  });

  //text editing controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatServices.sendMessage(recieverID, _messageController.text);

      //clear text controller after sending message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverEmail),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          //display messages
          Expanded(child: _buildMessageList()),

          //user input
          _buildMessageInput(context),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderID = _authService.currentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessages(recieverID, senderID),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        //loading

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        //return message list view
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc))
              .toList(),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is curerent user?
    bool isCurrentUser = data['senderID'] == _authService.currentUser()!.uid;

    //align message to the right is sender is the current user, otherwise left
    var alignment = isCurrentUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        spacing: 20,
        children: [
          Container(
            margin: EdgeInsets.only(right: 20, bottom: 10),
            child: 
          Text(
            data["message"],
            style: TextStyle(backgroundColor: Colors.green[100]),
          ),
          )
        ],
      ),
    );
  }

  //build user input
  Widget _buildMessageInput(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.all(15),
            child: AppTextfield(
              controller: _messageController,
              hintText: "Type a message",
              obscureText: false,
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(right: 15),
          child: //sendButton
          IconButton(
            onPressed: () {
              sendMessage();
            },
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            icon: const Icon(Icons.send),
          ),
        ),
      ],
    );
  }
}
