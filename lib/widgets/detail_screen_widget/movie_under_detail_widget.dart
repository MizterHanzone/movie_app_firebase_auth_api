import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_assignment/models/popular_model.dart';
import 'package:project_assignment/models/now_playing_model.dart';
import 'package:project_assignment/models/upcoming_model.dart';
import 'package:project_assignment/screens/detail_screen.dart';
import 'package:project_assignment/services/api.dart';
import 'package:project_assignment/utils/utils.dart';

class MovieUnderDetailWidget extends StatefulWidget {
  const MovieUnderDetailWidget({super.key});

  @override
  State<MovieUnderDetailWidget> createState() => _MovieUnderDetailWidgetState();
}

class _MovieUnderDetailWidgetState extends State<MovieUnderDetailWidget> {
  late Future<PopularModel> popularMovies;
  late Future<NowPlayingModel> nowPlayingMovies;
  late Future<UpComingModel> upcomingMovies;
  final ApiServices apiServices = ApiServices();
  String selectedCategory = "Popular";

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getPopularMovies();
    nowPlayingMovies = apiServices.getNowPlingMovies();
    upcomingMovies = apiServices.getUpComingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              categoryButton("Popular"),
              categoryButton("Now Playing"),
              categoryButton("Upcoming"),
            ],
          ),
        ),

        // Movie Grid Display
        FutureBuilder(
          future: _getMoviesByCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Failed to load movies"),
              );
            } else if (snapshot.hasData) {
              final movies = snapshot.data?.results ?? [];
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(id: movie.id),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Movie Poster
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ), // Rounded top corners
                            child: movie.backdropPath == null
                                ? Container(
                                    height: 120,
                                    color: Colors.grey[200],
                                    child: const Center(child: Text("Image not found")),
                                )
                                : CachedNetworkImage(
                                    imageUrl: "$urlImage${movie.backdropPath}",
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                          ),
                          // Movie Title
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("No data available"));
            }
          },
        ),
      ],
    );
  }

  // Method to get the appropriate movie list based on the selected category
  Future<dynamic> _getMoviesByCategory() {
    switch (selectedCategory) {
      case "Now Playing":
        return nowPlayingMovies;
      case "Upcoming":
        return upcomingMovies;
      default:
        return popularMovies;
    }
  }

    Widget categoryButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: selectedCategory == category
              ? Colors.blue
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: selectedCategory == category
                ? Colors.white
                : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
