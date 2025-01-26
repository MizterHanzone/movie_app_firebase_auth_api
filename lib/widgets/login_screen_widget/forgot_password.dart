import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_assignment/widgets/login_screen_widget/show_snack_bar.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            forgotPasswordDialog(context);
          },
          child: Text(
            "Forgot password ?",
            style: TextStyle(
                color: Theme
                    .of(context)
                    .primaryColor
            ),
          ),
        ),
      ),
    );
  }

  void forgotPasswordDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forgot password ?",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                          ),
                          Text(
                            "Type email for reset password.",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel)
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    controller: emailController,
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async {
                      await auth.sendPasswordResetEmail(
                          email: emailController.text
                      ).then((value){
                        showSnackBar(context, "Please check your email and reset your password.");
                      }).onError((error, stackTrace){
                        showSnackBar(context, error.toString());
                      });
                      Navigator.pop(context);
                      emailController.clear();
                    },
                    child: const Text("Send"),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}