class FipeDetail{
  final String Valor;
  final String Marca;
  final String Modelo;
  final int AnoModelo;
  final String Combustivel;
  final String CodigoFipe;
  final String MesReferencia;
  final int TipoVeiculo;
  final String SiglaCombustivel;

  const FipeDetail({
    required this.Valor, 
    required this.Marca,
    required this.Modelo,
    required this.AnoModelo,
    required this.Combustivel,
    required this.CodigoFipe,
    required this.MesReferencia,
    required this.TipoVeiculo,
    required this.SiglaCombustivel,
  });

  factory FipeDetail.fromJson(Map<String, dynamic> json) {
    return FipeDetail(
      Valor: json['Valor'],
      Marca: json['Marca'],
      Modelo: json['Modelo'],
      AnoModelo: json['AnoModelo'],
      Combustivel: json['Combustivel'],
      CodigoFipe: json['CodigoFipe'],
      MesReferencia: json['MesReferencia'],
      TipoVeiculo: json['TipoVeiculo'],
      SiglaCombustivel: json['SiglaCombustivel'],
    );
  }
}
