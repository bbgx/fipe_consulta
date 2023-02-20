import 'package:fipez/models/fipe_details.dart';
import 'package:fipez/models/fipe_request.dart';
import 'package:fipez/screens/fipe_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

import '../services/api.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedVehicleType = 'Selecione o tipo de veículo';
  String? selectedVehicleBrand;
  String? selectedVehicleModel;
  String? selectedVehicleYear;

  FipeDetail? fipeDetails;

  List<FipeRequest>? vehicleBrands;
  List<FipeRequest>? vehicleYears;
  List<FipeRequest>? vehicleModels;
  List<String> vehicleTypes = [
    'Selecione o tipo de veículo',
    'Carro',
    'Moto',
    'Caminhão'
  ];

  @override
  void initState() {
    super.initState();
  }

  void _fetchVehicleBrands(String listName) async {
    final records = await fetchData(selectedVehicleType, selectedVehicleBrand,
        selectedVehicleModel, selectedVehicleYear);

    setState(() {
      switch (listName) {
        case 'brand':
          vehicleBrands = records;
          break;
        case 'model':
          vehicleModels = records;
          break;
        case 'year':
          vehicleYears = records;
          break;
      }
    });
  }

  void _fetchFipeDetails() async {
    final details = await fetchDetailData(
        selectedVehicleType,
        selectedVehicleBrand.toString(),
        selectedVehicleModel.toString(),
        selectedVehicleYear.toString());

    setState(() {
      fipeDetails = details;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(children: [
              const SizedBox(height: 20),
              Image.asset("lib/images/fipe-logo.png"),
              const SizedBox(height: 50),
              Text('Bem-vindo novamente! Sentimos sua falta :)',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16)),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Tipo veiculo',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedVehicleType,
                  onChanged: (newValue) {
                    if (newValue != 'Selecione o tipo de veículo') {
                      setState(() {
                        selectedVehicleType = newValue!;
                      });
                      selectedVehicleYear = null;
                      selectedVehicleModel = null;
                      selectedVehicleBrand = null;
                      _fetchVehicleBrands('brand');
                    }
                  },
                  items: vehicleTypes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Marca',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SearchChoices.single(
                  isExpanded: true,
                  value: selectedVehicleBrand,
                  searchHint: 'Busque aqui',
                  displayClearIcon: false,
                  readOnly:
                      selectedVehicleType == 'Selecione o tipo de veículo',
                  onChanged: (newValue) {
                    setState(() {
                      selectedVehicleBrand = newValue;
                    });
                    selectedVehicleYear = null;
                    selectedVehicleModel = null;
                    _fetchVehicleBrands('model');
                  },
                  items: vehicleBrands != null
                      ? vehicleBrands?.map((brand) {
                          return DropdownMenuItem(
                            value: brand.codigo,
                            child: Text(brand.nome),
                          );
                        }).toList()
                      : [],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Modelo',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SearchChoices.single(
                  isExpanded: true,
                  value: selectedVehicleModel,
                  searchHint: 'Busque aqui',
                  displayClearIcon: false,
                  readOnly: selectedVehicleBrand == null,
                  onChanged: (newValue) {
                    setState(() {
                      selectedVehicleModel = newValue;
                    });
                    selectedVehicleYear = null;
                    _fetchVehicleBrands('year');
                  },
                  items: vehicleModels != null
                      ? vehicleModels?.map((model) {
                          return DropdownMenuItem(
                            value: model.codigo,
                            child: Text(model.nome),
                          );
                        }).toList()
                      : [],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 33.0),
                alignment: Alignment.topLeft,
                child: Text(
                  'Ano',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SearchChoices.single(
                  isExpanded: true,
                  value: selectedVehicleYear,
                  searchHint: 'Busque aqui',
                  displayClearIcon: false,
                  readOnly: selectedVehicleBrand == null,
                  onChanged: (newValue) {
                    setState(() {
                      selectedVehicleYear = newValue;
                    });
                    _fetchFipeDetails();
                  },
                  items: vehicleYears != null
                      ? vehicleYears?.map((year) {
                          return DropdownMenuItem(
                            value: year.codigo,
                            child: Text(year.nome),
                          );
                        }).toList()
                      : [],
                ),
              ),
              ElevatedButton(
                child: const Text('Pesquisar'),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isDismissible: true,
                      builder: (context) {
                        return FipeDetailsScreen(
                          fipeDetail: fipeDetails,
                        );
                      });
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
