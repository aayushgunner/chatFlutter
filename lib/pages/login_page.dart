import 'package:flutter/material.dart';
import 'package:newchat/auth/auth_service.dart';
import 'package:newchat/components/my_button.dart';
import 'package:newchat/components/my_textfield.dart';
// import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _pwContoller = TextEditingController();
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});
  void login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.sigInWithEmailPassword(
        _emailContoller.text,
        _pwContoller.text,
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  e.toString(),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.message_rounded,
              size: 60, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 50),
          Text(
            "Welcome back you have been missed",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),
          MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailContoller),
          const SizedBox(height: 10),
          MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _pwContoller),
          const SizedBox(height: 25),
          MyButton(text: "Login", onTap: () => login(context)),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Not a member? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            GestureDetector(
                onTap: onTap,
                child: Text(
                  "Register now",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ))
          ])
        ])));
  }
}
