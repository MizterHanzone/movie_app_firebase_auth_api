import 'package:flutter/material.dart';
import 'package:project_assignment/screens/base_screen.dart';
import 'package:project_assignment/screens/sign_up_screen.dart';
import 'package:project_assignment/services/authenticate_with_google.dart';
import 'package:project_assignment/services/authentication.datr.dart';
import 'package:project_assignment/widgets/login_screen_widget/button_widget.dart';
import 'package:project_assignment/widgets/login_screen_widget/forgot_password.dart';
import 'package:project_assignment/widgets/login_screen_widget/text_field_input_widget.dart';
import 'package:project_assignment/widgets/login_screen_widget/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthServices().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 50,
            right: 50,
            top: 50,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                Image.asset("lib/images/login.png", width: 200),
                const SizedBox(height: 20),
                TextFieldInputWidget(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.email,
                ),
                const SizedBox(height: 10),
                TextFieldInputWidget(
                  textEditingController: passwordController,
                  hintText: "Password",
                  isPass: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20),
                isLoading
                    ? const CircularProgressIndicator()
                    : ButtonWidget(
                  text: "Login",
                  onTap: loginUser,
                ),
                const ForgotPassword(),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: Container(height: 1, color: Theme.of(context).textTheme.labelLarge?.color,)),
                    const SizedBox(width: 10,),
                    const Text("or"),
                    const SizedBox(width: 10,),
                    Expanded(child: Container(height: 1, color: Theme.of(context).textTheme.labelLarge?.color,)),
                  ],
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseServices().signInWithGoogle();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => const BaseScreen(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).textTheme.labelLarge?.color,
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "lib/images/google.png",
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      const Text("Continue with Google"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
