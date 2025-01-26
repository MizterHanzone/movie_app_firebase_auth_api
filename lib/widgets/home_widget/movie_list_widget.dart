import 'package:flutter/material.dart';
import 'package:project_assignment/screens/detail_screen.dart';

class Movie {
  final int id;
  final String title;
  final String imageUrl;

  Movie({required this.id, required this.title, required this.imageUrl});
}

class MovieListWidget extends StatelessWidget {
  final String headText;
  final List<Movie> movies;

  const MovieListWidget({super.key, required this.headText, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              headText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemCount: movies.length,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return InkWell(
                  onTap: () {
                    if (movie.id != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(id: movie.id),
                        ),
                      );
                    }
                  },
                  child: Hero(
                    tag: 'movie_${movie.id}',  // Use a string tag with movie id
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).highlightColor.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              movie.imageUrl,
                              fit: BoxFit.cover,
                              height: 230,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            movie.title,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
