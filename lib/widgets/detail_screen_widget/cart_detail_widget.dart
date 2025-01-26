import 'package:flutter/material.dart';

class CartDetailWidget extends StatelessWidget {
  final String name;
  final String value;

  const CartDetailWidget({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.36,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).highlightColor,
      ),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis, // Truncate if text is too long
          ),
          const SizedBox(width: 5), // Add space between the texts
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis, // Truncate if text is too long
            ),
          ),
        ],
      ),
    );
  }
}
