import 'package:flutter/material.dart';
import 'package:newchat/auth/auth_service.dart';
import 'package:newchat/components/my_button.dart';
import 'package:newchat/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _pwContoller = TextEditingController();
  final TextEditingController _confirmPwContoller = TextEditingController();
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});
  void register(BuildContext context) {
    final _auth = AuthService();
    if (_pwContoller.text == _confirmPwContoller.text) {
      try {
        _auth.signUpWithEmailPassword(_emailContoller.text, _pwContoller.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    e.toString(),
                  ),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match"),
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
            "Create an account",
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
          const SizedBox(height: 10),
          MyTextField(
              hintText: "Confirm password",
              obscureText: true,
              controller: _confirmPwContoller),
          const SizedBox(height: 25),
          MyButton(text: "Register", onTap: () => register(context)),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Already have an account? ",
                style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            GestureDetector(
                onTap: onTap,
                child: Text(
                  "Login now!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ))
          ])
        ])));
  }
}
