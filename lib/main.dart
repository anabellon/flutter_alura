import 'package:flutter/material.dart';

void main() {
  runApp(
    ByteBankApp(),
  );
}

// extração do MaterialApp para a classe BytebankApp e assim utilizar o Hot Reload
class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// extraindo o body: Column() para um widget próprio
class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tranferências"),
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(100.0, 1000)),
          ItemTransferencia(Transferencia(200.0, 2000)),
          ItemTransferencia(Transferencia(300.0, 3000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // passar parametro
        child: Icon(Icons.add),
      ),
    );
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
}

class FormularioTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando Transferência"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            // responsável pela adição de margem entre o widget de texto e a tela
            padding: const EdgeInsets.all(16.0), // valor do espaçamento na tela
            child: TextField(
              style: TextStyle(
                fontSize: 24.0,
              ),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: "Valor",
                hintText: "0.00",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          TextField(),
          ElevatedButton(
            // versao atualizada do RaisedButton
            child: Text("Confirmar"),
            onPressed: () {
              debugPrint("Clicou no confirmar");
            },
          ),
        ],
      ),
    );
  }
}
