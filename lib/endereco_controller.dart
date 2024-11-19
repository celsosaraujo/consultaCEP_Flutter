import 'dart:convert';
import 'package:http/http.dart' as http;
import 'endereco.dart';

class EnderecoException implements Exception {
  final String message;
  EnderecoException(this.message);

  @override
  String toString() => 'EnderecoException: $message';
}

class EnderecoController {
  Future<Endereco> buscarEndereco(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');
    final resposta = await http.get(url);

    if (resposta.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(resposta.body);
      return Endereco.fromJson(json);
    } else {
      throw EnderecoException('Erro ao buscar endereço: ${resposta.statusCode}');
    }
  }
}