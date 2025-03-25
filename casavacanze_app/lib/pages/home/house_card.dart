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
      color: const Color.fromARGB(255, 255, 182, 193),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/img/back.jpg',
                  height: 180,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(location, style: const TextStyle(color: Colors.black)),
                  ],
                ),
                const SizedBox(height: 4),

                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.attach_money, size: 18),
                    Text(
                      '${price.toStringAsFixed(2)} a notte',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Azione al click
                      },
                      child: const Text('Prenota'),
                    ),
                    const SizedBox(width: 100),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {
                        // Azione per mettere tra i preferiti
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        // Azione per visualizzare i commenti
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
