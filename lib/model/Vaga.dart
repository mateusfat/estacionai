class Vaga{
  String? id;
  int? cod;
  bool? ocupada;

  Vaga({
    this.id,
    this.cod,
    this.ocupada,
  });

  Vaga.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    cod: json['cod'],
    ocupada: json['ocupada'],
  );

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'cod': cod,
      'ocupada': ocupada,
    };
  }
}