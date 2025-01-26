import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_assignment/models/detail_model.dart';
import 'package:project_assignment/services/api.dart';
import 'package:project_assignment/utils/utils.dart';
import 'package:project_assignment/widgets/detail_screen_widget/cart_detail_widget.dart';
import 'package:project_assignment/widgets/detail_screen_widget/kind_movie_widget.dart';
import 'package:project_assignment/widgets/detail_screen_widget/movie_under_detail_widget.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiServices apiServices = ApiServices();

  late Future<DetailModel> detail;

  @override
  void initState() {
    super.initState();
    detail = apiServices.getDetailMovies(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DetailModel>(
        future: detail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (snapshot.hasData) {
            final movie = snapshot.data!;
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.deepPurple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'movie_${movie.id}',
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("$urlImage${movie.backdropPath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.6),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).highlightColor),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 10,
                            child: KindMovieWidget(
                              value: movie.genres.map((e) => e['name']).join(", "),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Movie Title
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: movie.posterPath != null
                                ? Image.network(
                              "$urlImage${movie.posterPath}",
                              height: 250,
                              width: 200,
                              fit: BoxFit.cover,
                            )
                                : Container(
                                    height: 150,
                                    width: 100,
                                    color: Colors.grey.shade800,
                                    child: const Center(
                                      child: Text(
                                        "No Image",
                                          style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).highlightColor,
                                ),
                                child: Row(
                                  children: [
                                    Text(movie.releaseDate.day.toString()),
                                    const SizedBox(width: 10),
                                    Text(DateFormat('MMMM').format(movie.releaseDate)),
                                    const SizedBox(width: 10),
                                    Text(movie.releaseDate.year.toString()),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              CartDetailWidget(
                                name: "Vote Count: ",
                                value: movie.voteCount.toString(),
                              ),
                              const SizedBox(height: 10),
                              CartDetailWidget(
                                name: "Vote Average: ",
                                value: movie.voteAverage.toString(),
                              ),
                              const SizedBox(height: 10),
                              CartDetailWidget(
                                name: "Budget: ",
                                value: movie.budget.toString(),
                              ),
                              const SizedBox(height: 10),
                              CartDetailWidget(
                                name: "Revenue: ",
                                value: movie.revenue.toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Overview",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        movie.overview,
                        style: const TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const MovieUnderDetailWidget(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("No data available."));
          }
        },
      ),
    );
  }
}
