import 'package:casavacanze_app/service/http_urls.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Represents a booking (reservation) entity.
///
/// Contains details about the reservation such as dates, price, guests, and references to the house and user.
class Prenotazione {
  /// The unique identifier of the reservation.
  int id;

  /// The start date of the reservation in milliseconds since epoch.
  int dataInizio;

  /// The end date of the reservation in milliseconds since epoch.
  int dataFine;

  /// The total price of the reservation.
  double prezzoTotale;

  /// The number of people included in the reservation.
  int numeroPersone;

  /// The ID of the holiday house being booked.
  int casaVacanza;

  /// The ID of the user making the reservation.
  int utente;

  /// Creates a [Prenotazione] instance.
  ///
  /// All parameters are required.
  Prenotazione({
    required this.id,
    required this.dataInizio,
    required this.dataFine,
    required this.prezzoTotale,
    required this.numeroPersone,
    required this.casaVacanza,
    required this.utente,
  });

  /// Converts a [Prenotazione] instance to a JSON map suitable for the API.
  ///
  /// [prenotazione] is the reservation object to convert.
  /// Returns a map where dates are formatted as 'YYYY-MM-DD'.
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

  /// Sends the reservation to the server.
  ///
  /// [prenotazione] is the reservation details to send.
  /// [token] is the authentication token for the API request.
  ///
  /// Returns `200` on success, or `500` (or other error codes implicitly handled) on failure.
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
