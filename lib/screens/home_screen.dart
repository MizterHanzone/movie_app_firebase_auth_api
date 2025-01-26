import 'package:flutter/material.dart';
import 'package:project_assignment/models/popular_model.dart';
import 'package:project_assignment/models/top_rate_model.dart';
import 'package:project_assignment/screens/search_screen.dart';
import 'package:project_assignment/services/api.dart';
import 'package:project_assignment/widgets/home_widget/carousel_widget.dart';
import 'package:project_assignment/widgets/home_widget/tab_bar_movie_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<TopRateModel> topRateFuture;
  late Future<PopularModel> popularFuture;

  final ApiServices apiService = ApiServices();

  @override
  void initState() {
    super.initState();
    topRateFuture = apiService.getTopRateMovies();
    popularFuture = apiService.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Image.asset(
            "lib/images/tmdb.png",
            width: 200,
          ),
          backgroundColor: Colors.black,
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: const Icon(
                Icons.search,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FutureBuilder<TopRateModel>(
                future: topRateFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Error: ${snapshot.error}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
                    return const Center(
                      child: Text(
                        "No data available",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return CarouselWidget(data: snapshot.data!);
                },
              ),
            ),
            // Constrain TabBarMovieWidget using SliverFillRemaining
            const SliverFillRemaining(
              child: TabBarMovieWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
