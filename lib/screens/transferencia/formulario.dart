import 'package:flutter/material.dart';

import '../../components/editor.dart';
import 'lista.dart';

const _tituloAppBar = "Criando Transferencia";
const _textoBotaoConfirmar = "Confirmar";

const _rotuloCampoNumeroConta = "Numero Conta";
const _dicaCampoNumeroConta = "0000";

const _rotuloCampoValor = "Valor";
const _dicaCampoValor = "0.00";

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              // versao atualizada do RaisedButton
              child: Text(_textoBotaoConfirmar),
              onPressed: () => _criaTransferencia(context),
              //debugPrint("Clicou no confirmar"); debugPrint como boa prática
              // SnackBar para apresentar conteúdo em uma barra na parte inferior da tela
              /* if (numeroConta != null && valor != null) {
                  final transferenciaCriada = Transferencia(valor, numeroConta);
                  debugPrint('$transferenciaCriada');
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$transferenciaCriada'),
                    ),
                  );
                } */
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    // onPressed
    final int? numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double? valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      debugPrint('Criando transferência');
      debugPrint("$transferenciaCriada");
      Navigator.pop(context, transferenciaCriada); //tira a tela da pilha
    }
  }
}
