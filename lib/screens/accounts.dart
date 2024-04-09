import 'package:Gestion_de_Finanzas/main.dart';
import 'package:flutter/material.dart';

TextEditingController controlM = TextEditingController();
void main() => runApp(const MaterialApp(title: "Accounts", home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const accounts();
  }
}

// ignore: camel_case_types
class accounts extends StatefulWidget {
  const accounts({super.key});

  @override
  State<accounts> createState() => _accountsState();
}

// ignore: camel_case_types
class _accountsState extends State<accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        actions: const [
          /*      ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => fondo2),
                side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(color: bordes))),
            child: Icon(Icons.arrow_back),
          ) */
        ],
        backgroundColor: fondo2,
        centerTitle: true,
        title: const Text(
          "Cuentas",
          style: TextStyle(color: letras, fontFamily: fuente),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 30,
                    left: MediaQuery.of(context).size.width / 10),
                child: const Text(
                  "Saldo Total ",
                  style: TextStyle(
                      fontSize: 18, color: letras, fontFamily: fuente),
                ),
              ),
            ],
          ),
          // Container de Dinero en Efectivo------------------------------------------
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10),
                child: Text(
                  saldo_total,
                  style: const TextStyle(
                      fontSize: 22, color: letras, fontFamily: fuente),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: bordes),
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 1.10,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: const Icon(
                              size: 35,
                              Icons.account_balance_wallet_rounded,
                              color: Colors.green,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 24),
                            child: const Text("Dinero en Efectivo",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),

                          /* 
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: Text("0.0 ",
                                style: TextStyle(
                                    fontSize: 26, color: Color(0xFFF39422))),
                          ), */
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: [],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: const Text("Saldo",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 2),
                            child: Text(efectivo,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.20,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const accounts(),
                            ));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                            (states) => fondo2,
                          )),
                          child: const Text("Editar",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: letras,
                                  fontFamily: fuente)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Container de Cuenta corriente------------------------------------------
          const Row(
            children: [],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: bordes),
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 1.10,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: const Icon(
                              size: 35,
                              Icons.account_balance_outlined,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 24),
                            child: const Text("Banco",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 40),
                            child: const Text("(Cuenta corriente)",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        children: [],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: const Text("Saldo",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 2),
                            child: Text(corriente,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.20,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              barrierColor: fondo,
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 70,
                                  child: AlertDialog(
                                    backgroundColor: Colors.grey[300],
                                    title: const Text(
                                      "Editar",
                                      style: TextStyle(
                                          color: letras,
                                          fontFamily: fuente,
                                          fontSize: 18),
                                    ),
                                    content: Container(
                                      width: 270,
                                      height: 180,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Form(
                                              child: TextFormField(
                                            controller: controlM,
                                            decoration: const InputDecoration(
                                                icon:
                                                    Icon(Icons.monetization_on),
                                                labelText: "Monto",
                                                labelStyle: TextStyle(
                                                    fontFamily: fuente,
                                                    fontSize: 18)),
                                            keyboardType: const TextInputType
                                                .numberWithOptions(),
                                            /* inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp("[0-9]"))
                                                                        ], */
                                          )),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateColor
                                                              .resolveWith(
                                                    (states) => fondo,
                                                  )),
                                                  child: const Text("Cancelar",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: letras,
                                                          fontFamily: fuente)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                child: SizedBox(
                                                  width: 100,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      controlM.text;
                                                      /*                    final response = await supabase
                                          .from('transacciones')
                                          .insert({
                                        'descripcion': conceptoC.text,
                                        'fecha': Fecha.text,
                                        'id_transaccion': 2,
                                        'id_cuenta': Selectedindex,
                                        'id_user': session?.user.id,
                                        'monto': double.parse(montoC.text)
                                      }); */
                                                    },
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateColor
                                                                .resolveWith(
                                                      (states) => fondo2,
                                                    )),
                                                    child: const Text("Aceptar",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: letras,
                                                            fontFamily:
                                                                fuente)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                            (states) => fondo2,
                          )),
                          child: const Text("Editar",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: letras,
                                  fontFamily: fuente)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Container de Cuenta Ahorro------------------------------------------
          const Row(
            children: [],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: bordes),
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 1.10,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: const Icon(
                              size: 35,
                              Icons.account_balance,
                              color: Colors.blue,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 24),
                            child: Text("Banco",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 40),
                            child: Text("(Cuenta ahorro)",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: Text("Saldo",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 2),
                            child: Text(ahorro,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: letras,
                                    fontFamily: fuente)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.20,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const accounts(),
                            ));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                            (states) => fondo2,
                          )),
                          child: const Text("Editar",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: letras,
                                  fontFamily: fuente)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          /* Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 20,
                      bottom: MediaQuery.of(context).size.height / 18),
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: SpeedDial(
                      children: [
                        SpeedDialChild(
                          child: Icon(Icons.accessibility),
                          label: 'Primero',
                          onTap: () {/* Acción para el primer botón */},
                        ),
                        SpeedDialChild(
                          child: Icon(Icons.accessibility),
                          label: 'Segundo',
                          onTap: () {/* Acción para el segundo botón */},
                        ),
                      ],
                    ),
                  )),
            ],
          ) */
        ],
      ),
    );
  }
}
