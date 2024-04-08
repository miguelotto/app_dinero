import 'package:flutter/material.dart';
import 'package:Gestion_de_Finanzas/screens/homescreen.dart';

class CorrienteScreen extends StatefulWidget {
  const CorrienteScreen({super.key});

  @override
  State<CorrienteScreen> createState() => _CorrienteScreenState();
}

class _CorrienteScreenState extends State<CorrienteScreen> {
  final controlerSD = TextEditingController();
  final controlerSR = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF010038),
      appBar: AppBar(
        backgroundColor: const Color(0xFF293A80),
        centerTitle: true,
        title: const Text(
          "CUENTA CORRIENTE",
          style: TextStyle(color: Color(0xFFF39422)),
        ),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 90,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: const Color(0xFFF39422)),
                borderRadius: BorderRadiusDirectional.circular(20)),
            height: 80,
            width: 450,
            child: const Expanded(
              child: Text(
                "En esta pantalla podra introducir la actividad de la cuenta y en la pantalla *HOME* se mostraran los cambios de la ultima actividad junto con el saldo actual de la cuenta... (En caso de no haber un Deposito o Retiro no ingrese nada en las respectivas casillas)",
                style: TextStyle(color: Color(0xFFF39422)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            margin: const EdgeInsets.symmetric(horizontal: 80),
            child: TextField(
              controller: controlerSD,
              decoration: InputDecoration(
                  labelText: "Escribe cuanto saldo se va a DEPOSITAR...",
                  labelStyle: const TextStyle(color: Color(0xFFF39422)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide: const BorderSide(
                          color: Color(0xFF293A80), style: BorderStyle.solid))),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            margin: const EdgeInsets.symmetric(horizontal: 80),
            child: TextField(
              controller: controlerSR,
              decoration: InputDecoration(
                  labelText: "Escribe cuanto saldo se va a RETIRAR...",
                  labelStyle: const TextStyle(color: Color(0xFFF39422)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide: const BorderSide(
                          color: Color(0xFF293A80), style: BorderStyle.solid))),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
              (states) => const Color(0xFF293A80),
            )),
            child: const Text("ACTUALIZAR DATOS",
                style: TextStyle(color: Color(0xFFF39422))),
          )
        ]),
      ),
    );
  }
}
