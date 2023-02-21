import 'dart:async';
import 'dart:convert';
import 'package:fipez/models/fipe_details.dart';
import 'package:fipez/models/fipe_request.dart';
import 'package:http/http.dart' as http;

Future<List<FipeRequest>> fetchData(
  String selectedVehicleType, [
  String? selectedVehicleBrand,
  String? selectedVehicleModel,
  String? selectedVehicleYear,
]) async {
  final response = await http.get(
    Uri.parse(
      _getURL(
        selectedVehicleType,
        selectedVehicleBrand,
        selectedVehicleModel,
        selectedVehicleYear,
      ),
    ),
  );

  if (response.statusCode == 200) {
    final records = _formatReturn(
      response,
      selectedVehicleBrand != null && selectedVehicleModel == null,
    );
    return records;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<FipeDetail> fetchDetailData(
  String selectedVehicleType,
  String selectedVehicleBrand,
  String selectedVehicleModel,
  String selectedVehicleYear,
) async {
  final response = await http.get(
    Uri.parse(
      _getURL(
        selectedVehicleType,
        selectedVehicleBrand,
        selectedVehicleModel,
        selectedVehicleYear,
      ),
    ),
  );

  if (response.statusCode == 200) {
    return FipeDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

List<FipeRequest> _formatReturn(response, bool isModelRequest) {
  var data = json.decode(response.body);
  data = isModelRequest ? data['modelos'] :  data;
  
  return List<FipeRequest>.from(
    data.map(
      (rec) => FipeRequest.fromJson(rec) 
    ),
  );   
}

String _getURL(
  String selectedVehicleType,
  String? selectedVehicleBrand,
  String? selectedVehicleModel,
  String? selectedVehicleYear,
) {
  if (selectedVehicleType == 'Caminhão') {
    selectedVehicleType = 'caminhoes';
  }

  selectedVehicleType = selectedVehicleType.toLowerCase();

  var baseURL =
      'https://parallelum.com.br/fipe/api/v1/$selectedVehicleType/marcas';

  if (selectedVehicleBrand != null) baseURL += '/$selectedVehicleBrand/modelos';

  if (selectedVehicleModel != null) baseURL += '/$selectedVehicleModel/anos';

  if (selectedVehicleYear != null) baseURL += '/$selectedVehicleYear';

  return baseURL;
}
