import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_assignment/models/top_rate_model.dart';
import 'package:project_assignment/utils/utils.dart';

class CarouselWidget extends StatelessWidget {
  final TopRateModel data;

  const CarouselWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.results.isEmpty) {
      return const Center(
        child: Text(
          "No image to display",
        ),
      );
    }

    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
        itemCount: data.results?.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          var url = data.results?[index].backdropPath;
          if (url == null || url.isEmpty) {
            return const Center(
              child: Text(
                "No image available",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: "$urlImage$url",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
