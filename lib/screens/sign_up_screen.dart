import 'package:flutter/material.dart';
import 'package:project_assignment/screens/base_screen.dart';
import 'package:project_assignment/screens/login_screen.dart';
import 'package:project_assignment/services/authenticate_with_google.dart';
import 'package:project_assignment/services/authentication.datr.dart';
import 'package:project_assignment/widgets/login_screen_widget/button_widget.dart';
import 'package:project_assignment/widgets/login_screen_widget/show_snack_bar.dart';
import 'package:project_assignment/widgets/login_screen_widget/text_field_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseServices firebaseServices = FirebaseServices();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void signUpUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty || nameController.text.isEmpty) {
      showSnackBar(context, "Please fill in all fields");
      return;
    }

    setState(() {
      isLoading = true;
    });

    String res = await AuthServices().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      showSnackBar(context, "Signup successful!");
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    final user = await firebaseServices.signInWithGoogle();
    setState(() {
      isLoading = false;
    });

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BaseScreen(),
        ),
      );
      showSnackBar(context, "Google Sign-In successful!");
    } else {
      showSnackBar(context, "Google Sign-In failed. Please try again.");
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("lib/images/login.png", width: 200),
                const SizedBox(height: 20),
                TextFieldInputWidget(
                  textEditingController: nameController,
                  hintText: "Enter your name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 10),
                TextFieldInputWidget(
                  textEditingController: emailController,
                  hintText: "Enter your Email",
                  icon: Icons.email,
                ),
                const SizedBox(height: 10),
                TextFieldInputWidget(
                  textEditingController: passwordController,
                  hintText: "Enter your Password",
                  isPass: true,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  text: isLoading ? "Loading..." : "Sign Up",
                  onTap: signUpUser,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account ?"),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
