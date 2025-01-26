import 'package:flutter/material.dart';
import 'package:project_assignment/screens/home_screen.dart';
import 'package:project_assignment/screens/profile_screen.dart';
import 'package:project_assignment/screens/search_screen.dart';
import 'package:project_assignment/themes/theme.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.person),
              ),
            ],
            indicatorColor: Colors.transparent,
            labelColor: appTheme.primaryColor,
            unselectedLabelColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
