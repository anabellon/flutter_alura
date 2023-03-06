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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green.shade900,
          secondary: Colors.green[700],
        ),
      ),
      home: ListaTransferencias(),
    );
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
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
          final Future future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return FormularioTransferencia();
              },
            ),
          ); // as Future<Transferencia>; convertendo Future<dynamic> que é o retorno do .push para Future<Transferencia>
          //funcao de callback para receber retorno da tela
          future.then((transferenciaRecebida) {
            Future.delayed(
              Duration(seconds: 1),
              () {
                debugPrint("chegou no then do future");
                debugPrint("$transferenciaRecebida");
                if (transferenciaRecebida != null) {
                  setState(
                    () {
                      widget._transferencias.add(transferenciaRecebida);
                    },
                  );
                }
              },
            );
          });
        }, // passar parametro
      ),
    );
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
        title: Text("Criando Transferência"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: "Numero da Conta",
              dica: "0000",
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: "Valor",
              dica: "0.00",
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              // versao atualizada do RaisedButton
              child: Text("Confirmar"),
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

class Editor extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  Editor(
      {this.controlador,
      this.rotulo,
      this.dica,
      this.icone}); // Parametros Opcionais Nomeados: ({opcional}), para deixar parametro obrigatorio: (obrigatorio, {opcional})

  @override
  Widget build(BuildContext context) {
    return Padding(
      // responsável pela adição de margem entre o widget de texto e a tela
      padding: const EdgeInsets.all(16.0), // valor do espaçamento na tela
      child: TextField(
        controller: controlador,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon:
              icone != null ? Icon(icone) : null, // true = icone, false = null
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
