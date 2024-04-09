import 'package:Gestion_de_Finanzas/main.dart';
import 'package:Gestion_de_Finanzas/screens/accounts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:Gestion_de_Finanzas/screens/screen_ahorro.dart';
import 'package:Gestion_de_Finanzas/screens/screen_corriente.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore: depend_on_referenced_packages
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
    final session = Supabase.instance.client.auth.currentSession;
    final user = Supabase.instance.client.auth.currentUser;

    DateTime now = DateTime.now();
    String formatDate;
    String fromattedDate = "${now.day}/${now.month}/${now.year}";
    // ignore: non_constant_identifier_names
    String Selecteditem = "";
    // ignore: non_constant_identifier_names
    int Selectedindex = 0;
    DateTime _fecha = DateTime.now();
    // ignore: non_constant_identifier_names
    TextEditingController Fecha = TextEditingController();
    TextEditingController montoC = TextEditingController();
    TextEditingController conceptoC = TextEditingController();

    Future<void> seleccionarFecha(BuildContext context) async {
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

    @override
    void initState() {
      super.initState();
      setState(() {});
    }

    final _stream;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        floatingActionButton: SpeedDial(
          spaceBetweenChildren: 12,
          overlayColor: Colors.white,
          overlayOpacity: 0.7,
          animatedIcon: AnimatedIcons.menu_home,
          foregroundColor: letras,
          backgroundColor: fondo2,
          children: [
            SpeedDialChild(
              backgroundColor: fondo2,
              child: const Icon(
                Icons.money_off,
                color: Colors.red,
              ),
              label: 'Egreso',
              labelStyle: const TextStyle(color: letras, fontFamily: fuente),
              labelBackgroundColor: fondo2,
              onTap: () {
                showDialog(
                  barrierColor: fondo,
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        titlePadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 3.20,
                            top: MediaQuery.of(context).size.height / 22),
                        title: const Text(
                          "Egreso",
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
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.monetization_on),
                                    labelText: "Monto",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                /* inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ], */
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
                                decoration: const InputDecoration(
                                    icon: Icon(
                                        Icons.account_balance_wallet_outlined),
                                    labelText: "Seleccione la cuenta",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                              ),
                              Form(
                                  child: TextFormField(
                                controller: conceptoC,
                                decoration: const InputDecoration(
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
                                  seleccionarFecha(context);
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
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
                                      final response = await supabase
                                          .from('transacciones')
                                          .insert({
                                        'descripcion': conceptoC.text,
                                        'fecha': Fecha.text,
                                        'id_transaccion': 2,
                                        'id_cuenta': Selectedindex,
                                        'id_user': session?.user.id,
                                        'monto': double.parse(montoC.text)
                                      });
                                      if (response != true) {
                                        switch (Selectedindex) {
                                          case 1:
                                            ahorro = await buscarAhorro(ID);

                                            break;
                                          case 2:
                                            corriente =
                                                await buscarCorriente(ID);

                                            break;
                                          case 3:
                                            efectivo = await buscarEfectivo(ID);

                                            break;
                                        }

                                        saldo_total = await SaldoTotal(
                                            efectivo, corriente, ahorro);
                                        gasto = await buscarEgresos(ID);
                                        setState(() {
                                          saldo_total;
                                          gasto;
                                        });

                                        montoC.clear();
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'Egresos registrado satisfactoriamente',
                                          style: TextStyle(fontFamily: fuente),
                                        )));
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'A ocurrido un error porfavor intente de nuevo',
                                          style: TextStyle(fontFamily: fuente),
                                        )));
                                      }
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
            //--------------------------------------------INGRESOS SPEED DIAL-----------------------------
            SpeedDialChild(
              backgroundColor: fondo2,
              child: const Icon(
                Icons.monetization_on_outlined,
                color: Colors.green,
              ),
              label: 'Ingreso',
              labelStyle: const TextStyle(color: letras, fontFamily: fuente),
              labelBackgroundColor: fondo2,
              onTap: () {
                showDialog(
                  barrierColor: fondo,
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        titlePadding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 3.20,
                            top: MediaQuery.of(context).size.height / 22),
                        title: const Text(
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
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.monetization_on),
                                    labelText: "Monto",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                /* inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"))
                                ], */
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
                                decoration: const InputDecoration(
                                    icon: Icon(
                                        Icons.account_balance_wallet_outlined),
                                    labelText: "Seleccione la cuenta",
                                    labelStyle: TextStyle(
                                        fontFamily: fuente, fontSize: 18)),
                              ),
                              Form(
                                  child: TextFormField(
                                controller: conceptoC,
                                decoration: const InputDecoration(
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
                                  seleccionarFecha(context);
                                  setState(() {});
                                },
                                decoration: const InputDecoration(
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
                                      /*  debugPrint(session?.user?.id.toString());
                                      debugPrint(
                                          session?.user?.email.toString()); */
                                      final response = await supabase
                                          .from('transacciones')
                                          .insert({
                                        'descripcion': conceptoC.text,
                                        'fecha': Fecha.text,
                                        'id_transaccion': 1,
                                        'id_cuenta': Selectedindex,
                                        'id_user': session?.user.id,
                                        'monto': double.parse(montoC.text)
                                      });
                                      if (response != true) {
                                        var ahorros = '0.00';
                                        var corrientes = '0.00';
                                        var efectivos = '0.00';
                                        switch (Selectedindex) {
                                          case 1:
                                            ahorro = await buscarAhorro(ID);

                                            break;
                                          case 2:
                                            corrientes = (double.parse(
                                                        corriente) +
                                                    double.parse(montoC.text))
                                                .toString();
                                            corriente =
                                                await buscarCorriente(ID);

                                            break;
                                          case 3:
                                            efectivo = await buscarEfectivo(ID);

                                            break;
                                        }

                                        saldo_total = await SaldoTotal(
                                            efectivos, corrientes, ahorros);
                                        ingreso = await buscarIngresos(ID);
                                        setState(() {
                                          saldo_total;
                                          ingreso;
                                        });

                                        ingreso = (double.parse(ingreso) +
                                                double.parse(montoC.text))
                                            .toString();
                                        montoC.clear();
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'Ingresos registrado satisfactoriamente',
                                          style: TextStyle(fontFamily: fuente),
                                        )));
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'A ocurrido un error porfavor intente de nuevo',
                                          style: TextStyle(fontFamily: fuente),
                                        )));
                                      }
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
                style: const TextStyle(
                    color: letras, fontFamily: fuente, fontSize: 18),
              ),
            ),
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
                  "Opciones",
                  style: TextStyle(color: letras, fontFamily: fuente),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: const Text(
                  "Modo Oscuro",
                  style: TextStyle(color: letras, fontFamily: fuente),
                ),
                onTap: () {
                  /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CorrienteScreen(),
                  ));*/
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  "Cerrar Sesion",
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 22),
                              child: const Text(
                                "Saldo Total (Dolares) ",
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
                              child: Text(saldo_total,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      color: letras,
                                      fontFamily: fuente)),
                            ),
                          ],
                        ),
                        const SizedBox(
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
                                    child: const Icon(
                                      Icons.arrow_upward_rounded,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                22),
                                    child: const Text("Ingresos ",
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
                                    child: Text(ingreso,
                                        style: const TextStyle(
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
                                    child: const Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                22),
                                    child: const Text("Gastos",
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
                                    child: Text(gasto,
                                        style: const TextStyle(
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
                        const SizedBox(
                          height: 30,
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
              child: const Row(
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
                  stream: _stream = supabase
                      .from('transacciones')
                      .stream(primaryKey: ['id'])
                      .eq('id_user', ID)
                      .order('created_at', ascending: false),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
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

                            /* debugPrint(session?.user?.email.toString());
                            debugPrint(ID);
                            debugPrint(
                                transaccion['id_transaccion'].toString()); */
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
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: Text(
                                              dia[2],
                                              style: const TextStyle(
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
                                                padding: const EdgeInsets.only(
                                                    left: 10, top: 8),
                                                child: Text(
                                                  diaNombre,
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontFamily: fuente,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  mesNombre,
                                                  style: const TextStyle(
                                                      color: letras,
                                                      fontFamily: fuente,
                                                      fontSize: 18),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 25, left: 1),
                                            child: Text(
                                              dia[0],
                                              style: const TextStyle(
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
                                            padding: const EdgeInsets.only(
                                                top: 8.5, left: 180),
                                            child: Text(
                                              montoIngreso,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: fuente,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 180),
                                            child: Text(
                                              montoEgreso,
                                              style: const TextStyle(
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
