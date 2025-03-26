import 'package:casavacanze_app/service/http_urls.dart';
import 'package:casavacanze_app/pages/home/house_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String apiCase = HttpUrls.caseAPI;
const String host = HttpUrls.host;

class HomeContent extends StatefulWidget {
  const HomeContent({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<HomeContent> createState() => HomeContentState();
}

class HomeContentState extends State<HomeContent> {
  List<Map<String, dynamic>> houses = [];
  List<Map<String, dynamic>> filteredHouses = [];
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
        filteredHouses = List.from(houses);
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

  void filterHouses(String query) {
    setState(() {
      filteredHouses = houses.where((house) {
        final nome = (house['nome'] ?? '').toLowerCase();
        final indirizzo = (house['indirizzo'] ?? '').toLowerCase();
        final citta = (house['citta'] ?? '').toLowerCase();
        final regione = (house['regione'] ?? '').toLowerCase();
        final cap = (house['cap'] ?? '').toLowerCase();
        final descrizione = (house['descrizione'] ?? '').toLowerCase();

        return nome.contains(query.toLowerCase()) || citta.contains(query.toLowerCase()) ||
            indirizzo.contains(query.toLowerCase()) || regione.contains(query.toLowerCase()) || cap.contains(query.toLowerCase()) || descrizione.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: widget.scrollController,
      itemCount: filteredHouses.length,
      itemBuilder: (context, index) {
        final house = filteredHouses[index];

        return HouseCard(
          idHouse: house['id'] ?? 0,
          title: house['nome'] ?? '',
          location: house['indirizzo'] ?? '',
          imageUrl: house['immagine'] ?? '',
          price: (house['prezzo'] ?? 0).toDouble(),
        );
      },
    );
  }

}
