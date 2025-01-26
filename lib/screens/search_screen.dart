import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_assignment/models/search_model.dart';
import 'package:project_assignment/screens/detail_screen.dart';
import 'package:project_assignment/services/api.dart';
import 'package:project_assignment/utils/utils.dart';
import 'package:project_assignment/widgets/search_screen_widget/default_showing_widget.dart';

class SearchScreen extends StatefulWidget {
    const SearchScreen({Key? key}) : super(key: key);

    @override
    State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();

  SearchModel? searchModel;

  String selectedCategory = "Popular";

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        searchModel = null;
      });
    } else {
      apiServices.getSearchMovies(query).then((results) {
        setState(() {
          searchModel = results;
        });
      });
    }
  }

  Future<void> navigateToDetailScreen(int movieId) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(id: movieId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              CupertinoSearchTextField(
                controller: searchController,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: const Icon(Icons.cancel, color: Colors.grey),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    search(value);
                  } else {
                    setState(() {
                      searchModel = null;
                    });
                  }
                },
                onSuffixTap: () {
                  searchController.clear();
                  setState(() {
                    searchModel = null;
                  });
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: searchModel == null
                    ? const DefaultShowingWidget()
                    : GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.6,
                      ),
                      itemCount: searchModel!.results.length,
                      itemBuilder: (context, index) {
                      final movie = searchModel!.results[index];
                      return InkWell(
                          onTap: () => navigateToDetailScreen(movie.id),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
