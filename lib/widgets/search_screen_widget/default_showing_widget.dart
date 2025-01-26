import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_assignment/models/now_playing_model.dart';
import 'package:project_assignment/screens/detail_screen.dart';
import 'package:project_assignment/services/api.dart';
import 'package:project_assignment/utils/utils.dart';

class DefaultShowingWidget extends StatefulWidget {
  const DefaultShowingWidget({super.key});

  @override
  State<DefaultShowingWidget> createState() => _DefaultShowingWidgetState();
}

class _DefaultShowingWidgetState extends State<DefaultShowingWidget> {
  late Future<NowPlayingModel> nowPlayingFuture;
  final ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    nowPlayingFuture = apiServices.getNowPlingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NowPlayingModel>(
      future: nowPlayingFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              'Failed to load recommendations.',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData) {
          final movies = snapshot.data!.results;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
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
          return const Center(child: Text("No movies available."));
        }
      },
    );
  }
}
