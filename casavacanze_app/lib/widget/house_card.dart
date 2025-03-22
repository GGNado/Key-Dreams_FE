import 'package:flutter/material.dart';

class HouseCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final double price;

  const HouseCard({
    Key? key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(imageUrl, height: 180, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(location, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(
                  '€${price.toStringAsFixed(2)} a notte',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Azione al click
                  },
                  child: const Text('Prenota'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
