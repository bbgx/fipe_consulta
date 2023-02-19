import 'dart:async';
import 'dart:convert';
import 'package:fipez/models/FipeDetails.dart';
import 'package:fipez/models/FipeRequest.dart';
import 'package:http/http.dart' as http;

Future<List<FipeRequest>> fetchData(String selectedVehicleType,
    [String? selectedVehicleBrand,
    String? selectedVehicleModel,
    String? selectedVehicleYear]) async { 

  final response = await http.get(
    Uri.parse(getURL(selectedVehicleType, selectedVehicleBrand,
        selectedVehicleModel, selectedVehicleYear)),
  );

  if (response.statusCode == 200) {
    List<FipeRequest> records = FormatReturn(response,
        (selectedVehicleBrand != null && selectedVehicleModel == null));
    return records;
  } else {
    print('Caiu aqui!');
    throw Exception('Failed to load data');
  }
}

Future<FipeDetail> fetchDetailData(String selectedVehicleType, String selectedVehicleBrand, String selectedVehicleModel, String selectedVehicleYear) async{
  final response = await http.get(
    Uri.parse(getURL(selectedVehicleType, selectedVehicleBrand,
        selectedVehicleModel, selectedVehicleYear)),
  ); 

  if(response.statusCode == 200){
    return FipeDetail.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('Failed to load data');
  }
}

List<FipeRequest> FormatReturn(response, bool isModelRequest) {
  final data = json.decode(response.body);
  if (!isModelRequest) {
    return data
        .map((rec) => FipeRequest(
            nome: rec['nome'] as String, codigo: rec['codigo'] as String))
        .cast<FipeRequest>()
        .toList();
  }
  
  return data['modelos']
      .map((rec) => FipeRequest(
          nome: rec['nome'] as String, codigo: (rec['codigo'] as int).toString()))
      .cast<FipeRequest>()
      .toList();
}

String getURL(String selectedVehicleType, String? selectedVehicleBrand,
    String? selectedVehicleModel, String? selectedVehicleYear) {
  
  if (selectedVehicleType == 'Caminhão') {
    selectedVehicleType = 'caminhoes';
  }

  selectedVehicleType = selectedVehicleType.toLowerCase();

  String baseURL =
      'https://parallelum.com.br/fipe/api/v1/$selectedVehicleType/marcas';

  if (selectedVehicleBrand != null) baseURL += '/$selectedVehicleBrand/modelos';

  if (selectedVehicleModel != null) baseURL += '/$selectedVehicleModel/anos';

  if (selectedVehicleYear != null) baseURL += '/$selectedVehicleYear';

  print(baseURL);

  return baseURL;
}
