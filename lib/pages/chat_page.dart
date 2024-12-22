import 'package:flutter/material.dart';
import 'package:newchat/auth/auth_service.dart';
import 'package:newchat/components/chat_bubble.dart';
import 'package:newchat/components/my_textfield.dart';
import 'package:newchat/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  final String receiveEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiveEmail, required this.receiverID});

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(receiveEmail),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildUserInput(),
          ],
        ));
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
            ]));
  }

  Widget _buildUserInput() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Row(
          children: [
            Expanded(
              child: MyTextField(
                hintText: "Type a message",
                obscureText: false,
                controller: _messageController,
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                margin: EdgeInsets.only(right: 25),
                child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.arrow_upward, color: Colors.white)))
          ],
        ));
  }
}
