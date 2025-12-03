import 'package:casavacanze_app/service/http_urls.dart';
import 'package:casavacanze_app/pages/home/house_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String apiCase = HttpUrls.caseAPI;
const String host = HttpUrls.host;

/// The content widget for the Home screen.
///
/// Fetches and displays a list of houses, and provides filtering functionality.
class HomeContent extends StatefulWidget {
  /// The scroll controller for the list view.
  final ScrollController scrollController;

  /// Creates a [HomeContent] widget.
  ///
  /// [scrollController] is required to manage scrolling behavior.
  const HomeContent({super.key, required this.scrollController});

  @override
  State<HomeContent> createState() => HomeContentState();
}

/// The state class for [HomeContent].
///
/// Manages the list of houses, the filtered list, and the loading state.
class HomeContentState extends State<HomeContent> {
  /// All houses fetched from the API.
  List<Map<String, dynamic>> houses = [];

  /// Houses currently displayed after filtering.
  List<Map<String, dynamic>> filteredHouses = [];

  /// Whether the data is currently loading.
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHouses();
  }

  /// Fetches the list of houses from the API.
  ///
  /// Updates [houses] and [filteredHouses] upon success, or handles errors.
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

  /// Filters the list of houses based on a query string.
  ///
  /// [query] checks against the name, address, city, region, CAP, and description.
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
