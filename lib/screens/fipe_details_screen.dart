import 'package:fipez/models/fipe_details.dart';
import 'package:flutter/material.dart';

class FipeDetailsScreen extends StatefulWidget {
  final FipeDetail? fipeDetail;

  const FipeDetailsScreen({Key? key, required this.fipeDetail})
      : super(key: key);

  @override
  _FipeDatailsScreenState createState() => _FipeDatailsScreenState();
}

class _FipeDatailsScreenState extends State<FipeDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.fipeDetail == null
              ? const Text('Nulo')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Marca:',
                          
                        ),
                        Text(
                          widget.fipeDetail?.marca ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Modelo:',
                          
                        ),
                        Text(
                          widget.fipeDetail?.modelo ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ano do Modelo:',
                       
                        ),
                        Text(
                          widget.fipeDetail?.anoModelo.toString() ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mês de referência:',
                        ),
                        Text(
                          widget.fipeDetail?.mesReferencia ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Código FIPE:',
                        ),
                        Text(
                          widget.fipeDetail?.codigoFipe ?? '',
                        style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Valor:',
                          style: TextStyle(
                              fontSize: 20),
                        ),
                        Text(
                          widget.fipeDetail?.valor ?? '',
                          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
