import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchData(String selectedVehicleType) async {
  if (selectedVehicleType == 'Caminhão') {
    selectedVehicleType = 'caminhoes';
  }

  selectedVehicleType = selectedVehicleType.toLowerCase();

  final response = await http.get(
    Uri.parse(
        'https://parallelum.com.br/fipe/api/v1/$selectedVehicleType/marcas'),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = json.decode(response.body);
    List<String> brands =
        data.map((brand) => brand['nome'] as String).cast<String>().toList();
    print(data);
    return brands;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print('Caiu aqui!');
    throw Exception('Failed to load data');
  }
}
