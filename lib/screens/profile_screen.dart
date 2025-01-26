import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_assignment/screens/login_screen.dart';
import 'package:project_assignment/services/authentication.datr.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      // Fetch logged-in user
      final User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          userEmail = user.email;
        });

        // Fetch user details from Firestore
        final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc.data()?['name'] ?? "Unknown User";
          });
        }
      }
    } catch (e) {
      print("Error fetching user details: $e");
      // Optionally handle errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "lib/images/profile.png",
              fit: BoxFit.cover,
              height: size.height,
              width: size.width,
            ),
            // Bottom card
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: size.height * 0.4,
                  width: size.width * 0.9,
                  child: Card(
                    color: Colors.black.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey,
                                  image: const DecorationImage(
                                    image: AssetImage("lib/images/profile.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Checkmark indicator
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 95, 225, 99),
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Display Name
                          Text(
                            userName ?? "Loading name...",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Display Email
                          Text(
                            userEmail ?? "Loading email...",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await AuthServices().logOutUser();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Logout failed: $e"),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
