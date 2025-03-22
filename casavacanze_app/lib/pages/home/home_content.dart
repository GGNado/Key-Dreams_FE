import 'package:casavacanze_app/widget/house_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiCase = "/api/casaVacanza/all";
const String host = "http://172.16.218.64:8080";

class HomeContent extends StatefulWidget {
  const HomeContent({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<Map<String, dynamic>> houses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHouses();
  }

  Future<void> fetchHouses() async {
    final url = Uri.parse('$host$apiCase');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("Response: ${response.body}");
      final List<dynamic> jsonData = jsonDecode(response.body);
      setState(() {
        houses = jsonData.cast<Map<String, dynamic>>();
        print("Houses: $houses");
        isLoading = false;
      });
    } else {
      // gestisci errore
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: houses.length,
      itemBuilder: (context, index) {
        final house = houses[index];

        return HouseCard(
          title: house['nome'] ?? '',
          location: house['indirizzo'] ?? '',
          imageUrl: house['immagine'] ?? '',
          price: (house['prezzo'] ?? 0).toDouble(),
        );
      },
    );
  }
}
