import 'package:flutter/material.dart';

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
