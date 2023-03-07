import 'package:flutter/material.dart';

import 'formulario.dart';

const _tituloAppBar = "Transferencias";

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          //alterar a tela
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          ).then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        }, // passar parametro
      ),
    );
  }

  void _atualiza(transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(
        () {
          widget._transferencias.add(transferenciaRecebida);
        },
      );
    }
  }
}

// extraindo o body: Column() para um widget próprio
class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

// extraindo os Cards para um widget próprio
class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia; // privando atributo

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

// refatorando
class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return "Transferencia{valor: $valor, numeroConta: $numeroConta}";
  }
}
