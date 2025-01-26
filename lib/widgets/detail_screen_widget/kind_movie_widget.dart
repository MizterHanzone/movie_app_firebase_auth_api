import 'package:flutter/material.dart';

class KindMovieWidget extends StatelessWidget {
  final String value;

  const KindMovieWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration:  BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).highlightColor,
      ),
      child: Row(
        children: [
          Text(value),
        ],
      ),
    );
  }
}
