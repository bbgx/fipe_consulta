class FipeRequest {
  final String nome;
  final String codigo;

  const FipeRequest({required this.nome, required this.codigo});

  factory FipeRequest.fromJson(Map<String, dynamic> json) {
    return FipeRequest(
      nome: json['nome'],
      codigo: json['codigo'].toString(), 
    );
  }
}
