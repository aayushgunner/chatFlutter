import 'package:flutter/material.dart';
import 'package:newchat/auth/auth_service.dart';
import 'package:newchat/components/my_drawer.dart';
import 'package:newchat/components/user_tile.dart';
import 'package:newchat/pages/chat_page.dart';
import 'package:newchat/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authservice = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading");
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authservice.getCurrentUser()!.email) {
      return UserTile(
          text: userData["email"],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          receiveEmail: userData["email"],
                          receiverID: userData["uid"],
                        )));
          });
    } else {
      return Container();
    }
  }
}
