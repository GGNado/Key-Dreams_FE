/// Represents a House entity.
///
/// Contains details about a holiday house such as location, price, and availability.
class House {
  /// The unique identifier of the house.
  int id;

  /// The name of the house.
  String nome;

  /// The address of the house.
  String indirizzo;

  /// The city where the house is located.
  String citta;

  /// The region where the house is located.
  String regione;

  /// A description of the house.
  String descrizione;

  /// The price per night (or relevant unit).
  double prezzo;

  /// The number of beds available.
  int postiLetto;

  /// Whether the house is currently available for booking.
  bool disponibile;

  /// URL or path to the image of the house.
  String immagine;

  /// Creates a [House] instance.
  ///
  /// All parameters are required.
  House({
    required this.id,
    required this.nome,
    required this.indirizzo,
    required this.citta,
    required this.regione,
    required this.descrizione,
    required this.prezzo,
    required this.postiLetto,
    required this.disponibile,
    required this.immagine,
  });

  /// Creates a [House] instance from a JSON map.
  ///
  /// [json] is a map containing key-value pairs corresponding to [House] fields.
  /// Returns a populated [House] object.
  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      id: json['id'],
      nome: json['nome'],
      indirizzo: json['indirizzo'],
      citta: json['citta'],
      regione: json['regione'],
      descrizione: json['descrizione'],
      prezzo: json['prezzo'],
      postiLetto: json['postiLetto'],
      disponibile: json['disponibile'],
      immagine: json['immagine'],
    );
  }

  /// Converts the [House] instance to a JSON map.
  ///
  /// Returns a map representation of the house object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'indirizzo': indirizzo,
      'citta': citta,
      'regione': regione,
      'descrizione': descrizione,
      'prezzo': prezzo,
      'postiLetto': postiLetto,
      'disponibile': disponibile,
      'immagine': immagine,
    };
  }
}
