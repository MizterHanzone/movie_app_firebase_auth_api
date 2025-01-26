import 'package:flutter/material.dart';
import 'package:project_assignment/models/now_playing_model.dart';
import 'package:project_assignment/models/popular_model.dart';
import 'package:project_assignment/models/upcoming_model.dart';
import 'package:project_assignment/services/api.dart';
import 'package:project_assignment/utils/utils.dart';
import 'package:project_assignment/widgets/home_widget/movie_list_widget.dart';

class TabBarMovieWidget extends StatelessWidget {
  const TabBarMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final ApiServices apiService = ApiServices();

    Future<PopularModel> popularFuture = apiService.getPopularMovies();
    Future<NowPlayingModel> nowPlayingFuture = apiService.getNowPlingMovies();
    Future<UpComingModel> upComingFuture = apiService.getUpComingMovies();

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // TabBar for movie categories
          const TabBar(
            tabs: [
              Tab(text: 'Popular'),
              Tab(text: 'Now Playing'),
              Tab(text: 'Upcoming'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Popular Movies Tab
                FutureBuilder<PopularModel>(
                  future: popularFuture,
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
                          "No popular movie available.",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    final movies = snapshot.data!.results.map((movie) {
                      return Movie(
                        title: movie.title,
                        imageUrl: "$urlImage${movie.posterPath}", id: movie.id,
                      );
                    }).toList();

                    return MovieListWidget(
                      headText: "Popular",
                      movies: movies,
                    );
                  },
                ),
                // Top Now Playing Tab
                FutureBuilder<NowPlayingModel>(
                  future: nowPlayingFuture,
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
                          "No top-rated movie available.",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    final movies = snapshot.data!.results.map((movie) {
                      return Movie(
                        title: movie.title,
                        imageUrl: "$urlImage${movie.posterPath}", id: movie.id,
                      );
                    }).toList();

                    return MovieListWidget(
                      headText: "Top Rated",
                      movies: movies,
                    );
                  },
                ),
                // Upcoming Tab
                FutureBuilder(
                    future: upComingFuture,
                    builder: (context, snapshot){
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
                            "No top-rated movie available.",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      final movies = snapshot.data!.results.map((movie) {
                        return Movie(
                          title: movie.title,
                          imageUrl: "$urlImage${movie.posterPath}", id: movie.id,
                        );
                      }).toList();

                      return MovieListWidget(
                        headText: "Top Rated",
                        movies: movies,
                      );
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
