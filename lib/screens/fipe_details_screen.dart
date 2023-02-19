import 'package:fipez/models/FipeDetails.dart';
import 'package:flutter/material.dart';

class FipeDetailsScreen extends StatefulWidget{
  final FipeDetail? fipeDetail;

  const FipeDetailsScreen({Key? key, required this.fipeDetail}) : super(key: key);

  @override
  _FipeDatailsScreenState createState() => _FipeDatailsScreenState();
}

class _FipeDatailsScreenState extends State<FipeDetailsScreen>{
  
  @override
  void initState(){
    super.initState();
  }
  

  @override
  Widget build(BuildContext context){
    return Container(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height*0.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.fipeDetail == null ? const Text('Nulo') : 
          Column( 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Marca:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text(widget.fipeDetail?.Marca ?? ''),
                  const SizedBox(height: 10,)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Modelo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text(widget.fipeDetail?.Modelo ?? ''),
                  const SizedBox(height: 10,)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ano do Modelo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text(widget.fipeDetail?.AnoModelo.toString() ?? ''),
                  const SizedBox(height: 10,)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mês de referência:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text(widget.fipeDetail?.MesReferencia ?? ''),
                  const SizedBox(height: 10,)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Código FIPE:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Text(widget.fipeDetail?.CodigoFipe ?? ''),
                  const SizedBox(height: 10,)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Valor:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                  Text(widget.fipeDetail?.Valor ?? '', style: const TextStyle(fontSize: 20),),
                  const SizedBox(height: 10,)
                ],
              ),
          ],) 
        ],
      ),
    );
  } 
}
