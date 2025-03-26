import 'package:casavacanze_app/service/http_urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Prenotazione {
  int id;
  int dataInizio;
  int dataFine;
  double prezzoTotale;
  int numeroPersone;
  int casaVacanza;
  int utente;

  Prenotazione({
    required this.id,
    required this.dataInizio,
    required this.dataFine,
    required this.prezzoTotale,
    required this.numeroPersone,
    required this.casaVacanza,
    required this.utente,
  });


  static Map<String, dynamic> toJson(Prenotazione prenotazione) {
    return {
      'utenteId': prenotazione.utente,
      'casaVacanzaId': prenotazione.casaVacanza,
      'dataInizio': DateTime.fromMillisecondsSinceEpoch(prenotazione.dataInizio)
          .toIso8601String()
          .split('T')[0],
      'dataFine': DateTime.fromMillisecondsSinceEpoch(prenotazione.dataFine)
          .toIso8601String()
          .split('T')[0],
      'numeroPersone': prenotazione.numeroPersone,
    };
  }

  Future<int> inviaPrenotazione(Prenotazione prenotazione, String token) async {
    String host = HttpUrls.host;
    String apiCrea = HttpUrls.creaPrenotazioniAPI;

    final uri = Uri.parse('$host$apiCrea');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(Prenotazione.toJson(prenotazione)),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Prenotazione inviata con successo!');
      return 200;
    } else {
      print('Errore durante l\'invio: ${response.statusCode}');
      return 500;
    }
  }
}
