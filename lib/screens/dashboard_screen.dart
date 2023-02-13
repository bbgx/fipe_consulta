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
  String selectedVehicleBrand = 'Selecione a marca';

  List<String> vehicleBrands = ['Selecione a marca'];
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

  void _fetchVehicleBrands() async {
    List<String> brands = await fetchData(selectedVehicleType);
    setState(() {
      vehicleBrands = brands.cast<String>();
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedVehicleType,
                  hint: Container(
                    padding: const EdgeInsets.only(left: 25),
                    child: const Text('Selecione o tipo de veículo'),
                  ),
                  onChanged: (newValue) {
                    if (newValue != 'Selecione o tipo de veículo') {
                      setState(() {
                        selectedVehicleType = newValue!;
                      });
                      _fetchVehicleBrands();
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: SearchChoices.single(
                  isExpanded: true,
                  value: selectedVehicleBrand,
                  searchHint: 'Busque aqui',
                  displayClearIcon: false,
                  onChanged: (newValue) {
                    setState(() {
                      selectedVehicleBrand = newValue;
                    });
                  },
                  items: vehicleBrands.map((brand) {
                    return DropdownMenuItem(
                      value: brand,
                      child: Text(brand),
                    );
                  }).toList(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
