/// Contains global constants for HTTP URLs used throughout the application.
class HttpUrls {
  /// The base host address for the backend API.
  static const String host = "http://cityscape.vpsgh.it:8080";
  //static const String host = "http://localhost:8080";

  /// Endpoint for user login.
  static const String loginAPI = "/api/utente/login";

  /// Endpoint for validating the user token.
  static const String validateAPI = "/api/utente/validate";

  /// Endpoint for retrieving all holiday houses.
  static const String caseAPI = "/api/casaVacanza/all";

  /// Endpoint for creating a new reservation.
  static const String creaPrenotazioniAPI = "/api/prenotazione/crea";
}
