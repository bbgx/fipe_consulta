class FipeDetail {
  final String valor;
  final String marca;
  final String modelo;
  final int anoModelo;
  final String combustivel;
  final String codigoFipe;
  final String mesReferencia;
  final int tipoVeiculo;
  final String siglaCombustivel;

  const FipeDetail({
    required this.valor,
    required this.marca,
    required this.modelo,
    required this.anoModelo,
    required this.combustivel,
    required this.codigoFipe,
    required this.mesReferencia,
    required this.tipoVeiculo,
    required this.siglaCombustivel,
  });

  factory FipeDetail.fromJson(Map<String, dynamic> json) {
    return FipeDetail(
      valor: json['Valor'],
      marca: json['Marca'],
      modelo: json['Modelo'],
      anoModelo: json['AnoModelo'],
      combustivel: json['Combustivel'],
      codigoFipe: json['CodigoFipe'],
      mesReferencia: json['MesReferencia'],
      tipoVeiculo: json['TipoVeiculo'],
      siglaCombustivel: json['SiglaCombustivel'],
    );
  }
}
