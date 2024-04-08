import 'package:Gestion_de_Finanzas/main.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(title: "Accounts", home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return accounts();
  }
}

class accounts extends StatefulWidget {
  const accounts({super.key});

  @override
  State<accounts> createState() => _accountsState();
}

class _accountsState extends State<accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        actions: [
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
                child: Text(
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
                  "0.00",
                  style: TextStyle(
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: Icon(
                              size: 35,
                              Icons.money,
                              color: Colors.green,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 24),
                            child: Text("Dinero en Efectivo",
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
                            child: Text("0.00",
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
          // Container de Cuenta corriente------------------------------------------
          Row(
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: Icon(
                              size: 35,
                              Icons.balance,
                              color: Colors.yellow,
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
                            child: Text("(Cuenta corriente)",
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
                            child: Text("0.00",
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

          // Container de Cuenta Ahorro------------------------------------------
          Row(
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 10),
                            child: Icon(
                              size: 35,
                              Icons.balance,
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
                            child: Text("0.00",
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
