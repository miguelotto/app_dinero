import 'package:Gestion_de_Finanzas/main.dart';
import 'package:Gestion_de_Finanzas/screens/accounts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Gestion_de_Finanzas/screens/screen_ahorro.dart';
import 'package:Gestion_de_Finanzas/screens/screen_corriente.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _deleteCacheDir() async {
    final cachedir = await getTemporaryDirectory();
    if (cachedir.existsSync()) {
      cachedir.deleteSync(recursive: true);
    }
  }

  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();
    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formatDate;
    String fromattedDate = "${now.day}/${now.month}/${now.year}";
    String Selecteditem = "";
    int Selectedindex = 0;
    DateTime _fecha = DateTime.now();
    TextEditingController Fecha = TextEditingController();
    TextEditingController montoC = TextEditingController();
    TextEditingController conceptoC = TextEditingController();
    final _stream = supabase
        .from('transacciones')
        .stream(primaryKey: ['id'])
        .eq('id_user', session!.user!.id)
        .order('created_at', ascending: false);

    Future<void> _seleccionarFecha(BuildContext context) async {
      final DateTime? pick = await showDatePicker(
          context: context,
          initialDate: _fecha,
          firstDate: DateTime(2000),
          lastDate: DateTime(2050));

      if (pick != null) {
        setState(() {
          _fecha = pick;
          Fecha.text = "${_fecha.year}-${_fecha.month}-${_fecha.day}";
        });
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: SpeedDial(
          spaceBetweenChildren: 12,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          animatedIcon: AnimatedIcons.menu_home,
          foregroundColor: letras,
          backgroundColor: fondo2,
          children: [
            SpeedDialChild(
              backgroundColor: fondo2,
              child: Icon(
                Icons.money_off,
                color: Colors.red,
              ),
              label: 'Egreso',
              labelStyle: TextStyle(color: letras, fontFamily: fuente),
              labelBackgroundColor: fondo2,
              onTap: () {/* Acción para el primer botón */},
            ),
            SpeedDialChild(
              backgroundColor: fondo2,
              child: Icon(
                Icons.monetization_on_outlined,
                color: Colors.green,
              ),
              label: 'Ingreso',
              labelStyle: TextStyle(color: letras, fontFamily: fuente),
              labelBackgroundColor: fondo2,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        titlePadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 3.20,
                            top: MediaQuery.of(context).size.height / 22),
                        title: Text(
                          "Ingreso",
                          style: TextStyle(fontSize: 22, fontFamily: fuente),
                        ),
                        backgroundColor: fondo,
                        content: Container(
                          width: 300,
                          height: 400,
                          decoration: BoxDecoration(
                              //color: fondo2,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Form(
                                  child: TextFormField(
                                controller: montoC,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.monetization_on),
                                    labelText: "Monto",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ],
                              )),
                              DropdownButtonFormField<String>(
                                value: Selecteditem,
                                onChanged: (newvalue) {
                                  setState(() {
                                    Selecteditem = newvalue!;
                                    switch (newvalue) {
                                      case "":
                                        Selectedindex = 0;
                                        break;
                                      case "Cuenta Ahorro":
                                        Selectedindex = 1;
                                        break;
                                      case "Cuenta Corriente":
                                        Selectedindex = 2;
                                        break;
                                      case "Billetera":
                                        Selectedindex = 3;
                                        break;
                                    }
                                  });
                                },
                                items: <String>[
                                  "",
                                  "Cuenta Ahorro",
                                  "Cuenta Corriente",
                                  "Billetera"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                    icon: Icon(
                                        Icons.account_balance_wallet_outlined),
                                    labelText: "Seleccione la cuenta",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                              ),
                              Form(
                                  child: TextFormField(
                                controller: conceptoC,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.message_outlined),
                                    labelText: "concepto",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                                keyboardType: TextInputType.text,
                              )),
                              Form(
                                  child: TextFormField(
                                readOnly: true,
                                controller: Fecha,
                                onTap: () {
                                  _seleccionarFecha(context);
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    icon: Icon(Icons.date_range),
                                    labelText: "Fecha de transaccion",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                                keyboardType: TextInputType.datetime,
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateColor.resolveWith(
                                        (states) => fondo,
                                      )),
                                      child: const Text("Cancelar",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: letras,
                                              fontFamily: fuente)),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      debugPrint(session?.user?.id.toString());
                                      debugPrint(
                                          session?.user?.email.toString());
                                      final response = await supabase
                                          .from('transacciones')
                                          .insert({
                                        'descripcion': conceptoC.text,
                                        'fecha': Fecha.text,
                                        'id_transaccion': 1,
                                        'id_cuenta': Selectedindex,
                                        'id_user': session?.user?.id,
                                        'monto': double.parse(montoC.text)
                                      });
                                      if (response != true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'Ingresos registrado satisfactoriamente',
                                          style: TextStyle(fontFamily: fuente),
                                        )));
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                          'A ocurrido un error porfavor intente de nuevo',
                                          style: TextStyle(fontFamily: fuente),
                                        )));
                                      }
                                      /* final response = await supabase
                                        .from("tipo transaccion")
                                        .select("monto")
                                        .eq("nombre", "Ingreso"); */
                                      //final xd = int.tryParse( response[0].toString());
                                      /* final valor = double.parse(
                                            response[0]['monto'].toString()) +
                                        double.parse(montoC.text);

                                    final response2 = await supabase
                                        .from("tipo transaccion")
                                        .update({'monto': valor}).eq(
                                            'monto', 'Ingreso'); */
                                      /* final response = await supabase
                                        .from("tipo transaccion")
                                        .select("monto.sum()"); */
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateColor.resolveWith(
                                      (states) => fondo2,
                                    )),
                                    child: const Text("Aceptar",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: letras,
                                            fontFamily: fuente)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                );
              },
            ),
          ],
        ),
        backgroundColor: fondo,
        appBar: AppBar(
          backgroundColor: fondo2,
          // centerTitle: true,
          title: const Text(
            "Inicio",
            style: TextStyle(color: letras, fontFamily: fuente),
          ),

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                fromattedDate,
                style:
                    TextStyle(color: letras, fontFamily: fuente, fontSize: 18),
              ),
            ),

            /* 
          ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => fondo2),
                side: MaterialStateBorderSide.resolveWith(
                    (states) => const BorderSide(color: bordes))),
            child: Text(
              fromattedDate,
              style: const TextStyle(color: letras),
            ),
          ) */
          ],
        ),
        drawer: Drawer(
          backgroundColor: fondo,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: fondo2),
                child: Text(
                  "OPCIONES",
                  style: TextStyle(color: letras, fontFamily: fuente),
                ),
              ),
              ListTile(
                title: const Text(
                  "CUENTA CORRIENTE",
                  style: TextStyle(color: letras, fontFamily: fuente),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CorrienteScreen(),
                  ));
                },
              ),
              ListTile(
                title: const Text(
                  "CUENTA AHORRO",
                  style: TextStyle(color: letras, fontFamily: fuente),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AhorroScreen(),
                  ));
                },
              ),
              ListTile(
                title: const Text(
                  "Cerrar sesion",
                  style: TextStyle(color: letras, fontFamily: fuente),
                ),
                onTap: () async {
                  await supabase.auth.signOut();

                  _deleteAppDir();
                  _deleteCacheDir();

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Home(),
                  ));
                },
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 22),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: bordes),
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 1.10,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 22),
                              child: Text(
                                "Saldo Total ",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: letras,
                                    fontFamily: fuente),
                              ),
                            ),
                          ],
                        ),
                        /* 
                      SizedBox(
                        height: ,
                      ), */
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 18),
                              child: Text("0.0 ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: letras,
                                      fontFamily: fuente)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: bordes),
                              borderRadius:
                                  BorderRadiusDirectional.circular(20)),
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width / 1.20,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                20),
                                    child: Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                22),
                                    child: Text("Ingresos ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: letras,
                                            fontFamily: fuente)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                4),
                                    child: Text("0.00",
                                        style: TextStyle(
                                            fontSize: 26,
                                            color: Colors.green,
                                            fontFamily: fuente)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                20),
                                    child: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                22),
                                    child: Text("Gastos",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: letras,
                                            fontFamily: fuente)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                3.40),
                                    child: Text("0.00",
                                        style: TextStyle(
                                            fontSize: 26,
                                            color: Colors.red,
                                            fontFamily: fuente)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //
                        SizedBox(
                          height: 30,
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
                            child: const Text("Cuentas",
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
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 18,
                  left: MediaQuery.of(context).size.width / 10),
              child: Row(
                children: [
                  Text(
                    "Transacciones",
                    style: TextStyle(
                        fontFamily: fuente, fontSize: 22, color: letras),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 22),
                child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final transacciones = snapshot.data!;
                    final items = transacciones.length;

                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 1.10,
                      height: MediaQuery.of(context).size.height / 3,
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: items,
                          itemBuilder: (context, index) {
                            //items = transacciones.length;

                            final transaccion = transacciones[index];
                            final fechas = transaccion['fecha'].toString();
                            final dia = fechas.split('-');
                            debugPrint(transaccion['fecha'].toString());
                            final fechaformat = DateTime.parse(fechas);
                            final String diaNombre =
                                DateFormat('EEEE').format(fechaformat);
                            final String mesNombre =
                                DateFormat('MMMM').format(fechaformat);

                            final monto = transaccion['monto'].toString();
                            var montoIngreso = "0.00";
                            var montoEgreso = "0.00";

                            debugPrint(session?.user?.email.toString());
                            debugPrint(
                                transaccion['id_transaccion'].toString());
                            if (int.parse(
                                    transaccion['id_transaccion'].toString()) ==
                                1) {
                              montoIngreso = monto.toString();
                            } else if (int.parse(
                                    transaccion['id_transaccion'].toString()) ==
                                2) {
                              montoEgreso = monto.toString();
                            }

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                  width: 200,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: Text(
                                              dia[2],
                                              style: TextStyle(
                                                  color: letras,
                                                  fontFamily: fuente,
                                                  fontSize: 28),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              /*          Text(
                                              fechas,
                                              style: TextStyle(
                                                  color: letras,
                                                  fontFamily: fuente,
                                                  fontSize: 18),
                                            ), */

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, top: 8),
                                                child: Text(
                                                  diaNombre,
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: fuente,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Text(
                                                  mesNombre,
                                                  style: TextStyle(
                                                      color: letras,
                                                      fontFamily: fuente,
                                                      fontSize: 18),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 25, left: 1),
                                            child: Text(
                                              dia[0],
                                              style: TextStyle(
                                                  color: letras,
                                                  fontFamily: fuente,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.5, left: 180),
                                            child: Text(
                                              montoIngreso,
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: fuente,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 180),
                                            child: Text(
                                              montoEgreso,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: fuente,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class containerIngreso extends StatelessWidget {
  const containerIngreso({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
      width: 200,
      height: 200,
      decoration:
          BoxDecoration(color: fondo2, borderRadius: BorderRadius.circular(20)),
      child: Text("SIIIIIIII"),
    ));
  }
}
