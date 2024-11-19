import 'package:flutter/material.dart';
import 'endereco_controller.dart';
import 'endereco.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busca de Endereço',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EnderecoScreen(),
    );
  }
}

class EnderecoScreen extends StatefulWidget {
  @override
  _EnderecoScreenState createState() => _EnderecoScreenState();
}

class _EnderecoScreenState extends State<EnderecoScreen> {
  final TextEditingController _cepController = TextEditingController();
  Endereco? _endereco;
  String _errorMessage = '';

  void _buscarEndereco() async {
    final controller = EnderecoController();
    setState(() {
      _errorMessage = '';
    });

    try {
      final cep = _cepController.text;
      if (cep.isEmpty) {
        throw EnderecoException('Por favor, insira um CEP válido.');
      }
      Endereco endereco = await controller.buscarEndereco(cep);
      setState(() {
        _endereco = endereco;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _endereco = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca de Endereço'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'Informe o CEP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _buscarEndereco,
              child: Text('Buscar'),
            ),
            SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            if (_endereco != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Logradouro: ${_endereco!.logradouro}'),
                  Text('Bairro: ${_endereco!.bairro}'),
                  Text('Cidade: ${_endereco!.localidade}'),
                  Text('UF: ${_endereco!.uf}'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}