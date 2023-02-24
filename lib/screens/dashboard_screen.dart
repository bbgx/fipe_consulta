import 'package:fipez/ad_helper.dart';
import 'package:fipez/models/fipe_details.dart';
import 'package:fipez/models/fipe_request.dart';
import 'package:fipez/screens/fipe_details_screen.dart';
import 'package:fipez/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../services/api.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedVehicleType; 
  String? selectedVehicleBrand;
  String? selectedVehicleModel;
  String? selectedVehicleYear;

  FipeDetail? fipeDetails;

  List<FipeRequest>? vehicleBrands;
  List<FipeRequest>? vehicleYears;
  List<FipeRequest>? vehicleModels;
  List<FipeRequest> vehicleTypes = [ 
    const FipeRequest(nome: 'Carro', codigo: 'carros'),
    const FipeRequest(nome: 'Moto', codigo: 'motos'),
    const FipeRequest(nome: 'Caminhão', codigo: 'caminhoes')
  ];

  static final _kAdIndex = 4;

  BannerAd? _ad; 

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _ad != null) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState(){
    super.initState();
    
    BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
        ad.dispose();
        print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
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
              const SizedBox(height: 30),
              Text('Bem-vindo novamente! Sentimos sua falta :)',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16)),
              const SizedBox(
                height: 25,
              ),
              CustomDropdown(
                label: 'Tipo de veiculo',
                value: selectedVehicleType,
                onChange: (String? newValue){
                  setState(() {
                    selectedVehicleType = newValue.toString();                    
                  });
                  selectedVehicleBrand = null;  
                  selectedVehicleModel = null;
                  selectedVehicleYear = null;
                  _fetchVehicleBrands('brand');
                },
                items: vehicleTypes,
              ),
              CustomDropdown(
                label: 'Marca',
                value: selectedVehicleBrand,
                disabled: selectedVehicleType == null,
                onChange: (String? newValue){
                  setState(() {
                    selectedVehicleBrand = newValue.toString();                    
                  });  
                  selectedVehicleModel = null;
                  selectedVehicleYear = null;
                  _fetchVehicleBrands('model');
                },
                items: vehicleBrands,
              ),              
              CustomDropdown(
                label: 'Modelo',
                value: selectedVehicleModel,
                disabled: selectedVehicleBrand == null,
                onChange: (String? newValue){
                  setState(() {
                    selectedVehicleModel = newValue.toString();                    
                  });  
                  selectedVehicleYear = null;
                  _fetchVehicleBrands('year');
                },
                items: vehicleModels,
              ),
              CustomDropdown(
                label: 'Ano',
                value: selectedVehicleYear,
                disabled: selectedVehicleModel == null,
                onChange: (String? newValue){
                  setState(() {
                    selectedVehicleYear = newValue.toString();                    
                  });  
                  _fetchFipeDetails();
                },
                items: vehicleYears,
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
                      }
                  );
                },
              ),
              Container(
                width: _ad!.size.width.toDouble(),
                height: 72.0,
                alignment: Alignment.center,
                child: AdWidget(ad: _ad!),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _fetchFipeDetails() async {
    final details = await fetchDetailData(
        selectedVehicleType.toString(),
        selectedVehicleBrand.toString(),
        selectedVehicleModel.toString(),
        selectedVehicleYear.toString());

    setState(() {
      fipeDetails = details;
    });
  }

  void _fetchVehicleBrands(String listName) async {
    final records = await fetchData(selectedVehicleType.toString(), selectedVehicleBrand,
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
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Modelo',
      style: TextStyle(color: Colors.grey[700], fontSize: 16),
    );
  }
}
