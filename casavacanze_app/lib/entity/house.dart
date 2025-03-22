class House {
  int id;
  String nome;
  String indirizzo;
  String citta;
  String regione;
  String descrizione;
  double prezzo;
  int postiLetto;
  bool disponibile;
  String immagine;

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
