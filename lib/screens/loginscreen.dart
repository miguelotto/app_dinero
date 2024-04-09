import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Gestion_de_Finanzas/main.dart';

final controlerP = TextEditingController();
final controlerU = TextEditingController();
final controlerC = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fondo,
        appBar: AppBar(
          backgroundColor: fondo2,
          title: const Text(
            "Registrar Cuenta",
            style: TextStyle(color: letras, fontFamily: fuente),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 60,
/*                       decoration:
                          BoxDecoration(border: Border.all(color: bordes)), */
                      child: const Text(
                          "Si aun no estas registrado, crea una cuenta para mayor seguridad",
                          style: TextStyle(
                              color: letras,
                              fontFamily: fuente,
                              fontSize: 20))),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 60,
                      /*         decoration:
                          BoxDecoration(border: Border.all(color: bordes)), */
                      child: const Text(
                          "Por favor, ingresa un Usuario, un Correo y un PIN personal que sean faciles de recordar",
                          style: TextStyle(
                              color: letras,
                              fontFamily: fuente,
                              fontSize: 20))),
                ),
                const SizedBox(
                  height: 90,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.20,
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          final isValidEmail = EmailValidator.validate(value!);
                          return isValidEmail
                              ? null
                              : 'Introduce una dirección de correo válida';
                        },
                        controller: controlerC,
                        decoration: InputDecoration(
                            labelText: "Escribe tu CORREO...",
                            labelStyle: const TextStyle(
                                color: letras, fontFamily: fuente),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90),
                                borderSide: const BorderSide(
                                    color: fondo2, style: BorderStyle.solid))),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.20,
                  child: TextField(
                    controller: controlerP,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    decoration: InputDecoration(
                        labelText: "Escribe tu PIN...",
                        labelStyle:
                            const TextStyle(color: letras, fontFamily: fuente),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90),
                            borderSide: const BorderSide(
                                color: fondo2, style: BorderStyle.solid))),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    insertar(controlerC.text, controlerP.text, context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                    (states) => fondo2,
                  )),
                  child: const Text("Aceptar",
                      style: TextStyle(color: letras, fontFamily: fuente)),
                )
              ],
            ),
          ],
        ));
  }
}
