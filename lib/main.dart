import 'package:flutter/material.dart';

import 'package:Gestion_de_Finanzas/screens/homescreen.dart';
import 'package:Gestion_de_Finanzas/screens/loginscreen.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import 'package:proyecto_final/screens/screen_ahorro.dart';
// import 'package:proyecto_final/screens/screen_corriente.dart';
//const fondo = Color(0xFF010038);
const fondo = Color(0xFFF4F7ED);

//const letras = Color(0xFFF39422);
const letras = Color(0xFF000000);
//const bordes = Color(0xFFF39422);
const bordes = Color(0xFF9b9b9b);
//const fondo2 = Color(0xFF293A80);
const fondo2 = Color(0xFFF9E4B7);
const fuente = "SourceSans";

final controlerP = TextEditingController();
final controlerC = TextEditingController();
//final user = Supabase.instance.client.auth.currentUser;
//final session = Supabase.instance.client.auth.currentSession;
//final cerrar = Supabase.instance.client.auth.signOut();
final supabase = Supabase.instance.client;
// ignore: non_constant_identifier_names
String ID = "";

var ingreso = "0.00";
var gasto = "0.00";
// ignore: non_constant_identifier_names
var saldo_total = "0.00";
var efectivo = "0.00";
var ahorro = "0.00";
var corriente = "0.00";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://zoqdkwwjmgojdwohhwex.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpvcWRrd3dqbWdvamR3b2hod2V4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI0OTgwNjksImV4cCI6MjAyODA3NDA2OX0.gu6mbAotQP8fB_4OrM2tS-jS6iVZ0X0L5QQufklrdK8');
  runApp(MaterialApp(
    //localizationsDelegates: [GlobalMa],
    title: "Finanzas",
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    home: const Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fondo,
        appBar: AppBar(
          backgroundColor: fondo2,
          title: const Text(
            "Iniciar Sesion",
            style: TextStyle(color: letras, fontFamily: fuente),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      height: 60,
                      /*  decoration:
                          BoxDecoration(border: Border.all(color: bordes)), */
                      child: const Text(
                          "La Aplicacion Perfecta para gestionar de forma correcta el saldo de tu cuenta bancarias",
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
                          "Por favor, ingresa tu Usuario y tu PIN personal para entrar en la APP",
                          style: TextStyle(
                              color: letras,
                              fontFamily: fuente,
                              fontSize: 20))),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.20,
                  child: TextField(
                    controller: controlerC,
                    decoration: InputDecoration(
                        labelText: "Escribe tu correo...",
                        labelStyle:
                            const TextStyle(color: letras, fontFamily: fuente),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90),
                            borderSide: const BorderSide(
                                color: fondo2, style: BorderStyle.solid))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.20,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                    ],
                    controller: controlerP,
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
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    verificar(context, controlerP.text, controlerC.text);
                    /*  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    )); */
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                    (states) => fondo2,
                  )),
                  child: const Text("ACCEDER",
                      style: TextStyle(color: letras, fontFamily: fuente)),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateColor.resolveWith((states) => fondo),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                  ),
                  child: const Text(
                    "¿Aun no estas registrado?",
                    style: TextStyle(color: letras, fontFamily: fuente),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}

Future<String> buscarEgresos(String id) async {
  final egresos = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 2)
      .eq('id_user', id);

  if (egresos[0]['sum'] != null) {
    gasto = egresos[0]['sum'].toString();
  } else {
    gasto = '0.00';
  }
  return gasto;
}

Future<String> buscarIngresos(String id) async {
  final ingresos = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 1)
      .eq('id_user', id);

  if (ingresos[0]['sum'] != null) {
    ingreso = ingresos[0]['sum'].toString();
  } else {
    ingreso = "0.00";
  }
  return ingreso;
}

Future<String> buscarEfectivo(String id) async {
  String gastos = "0.00";
  final efectivos = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 1)
      .eq('id_user', id)
      .eq('id_cuenta', 3);
  final efectivosGatos = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 2)
      .eq('id_user', id)
      .eq('id_cuenta', 3);

  if (efectivos[0]['sum'] != null) {
    efectivo = efectivos[0]['sum'].toString();
  } else {
    efectivo = '0.00';
  }

  if (efectivosGatos[0]['sum'] != null) {
    gastos = efectivosGatos[0]['sum'].toString();
  } else {
    gastos = '0.00';
  }

  return (double.parse(efectivo) - double.parse(gastos)).toString();
}

Future<String> buscarAhorro(String id) async {
  String gastos = "0.00";
  // ignore: non_constant_identifier_names
  final Ahorros = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 1)
      .eq('id_user', id)
      .eq('id_cuenta', 1);
  // ignore: non_constant_identifier_names
  final AhorrosGastos = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 2)
      .eq('id_user', id)
      .eq('id_cuenta', 1);

  if (Ahorros[0]['sum'] != null) {
    ahorro = Ahorros[0]['sum'].toString();
  } else {
    ahorro = '0.00';
  }
  if (AhorrosGastos[0]['sum'] != null) {
    gastos = AhorrosGastos[0]['sum'].toString();
  } else {
    gastos = '0.00';
  }
  return (double.parse(ahorro) - double.parse(gastos)).toString();
}

Future<String> buscarCorriente(String id) async {
  String gasto = "0.00";
  // ignore: non_constant_identifier_names
  final Corriente = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 1)
      .eq('id_user', id)
      .eq('id_cuenta', 2);
  // ignore: non_constant_identifier_names
  final CorrienteGasto = await supabase
      .from('transacciones')
      .select('monto.sum()')
      .eq('id_transaccion', 2)
      .eq('id_user', id)
      .eq('id_cuenta', 2);

  if (Corriente[0]['sum'] != null) {
    corriente = Corriente[0]['sum'].toString();
  } else {
    corriente = '0.00';
  }

  if (CorrienteGasto[0]['sum'] != null) {
    gasto = CorrienteGasto[0]['sum'].toString();
  } else {
    gasto = '0.00';
  }

  return (double.parse(corriente) - double.parse(gasto)).toString();
}

// ignore: non_constant_identifier_names
Future<String> SaldoTotal(
    String efectivo, String corriente, String ahorro) async {
  return (double.parse(efectivo) +
          double.parse(corriente) +
          double.parse(ahorro))
      .toString();
}

late final Future xd;
void verificar(context, String contra, String correo) async {
  try {
    final response =
        await supabase.auth.signInWithPassword(password: contra, email: correo);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          'Bienvenido de nuevo',
          style: TextStyle(fontFamily: fuente),
        )));
    final user = Supabase.instance.client.auth.currentUser;
    ID = user!.id;
    controlerC.clear();

    controlerP.clear();

    ingreso = await buscarIngresos(ID);
    gasto = await buscarEgresos(ID);
    efectivo = await buscarEfectivo(ID);
    ahorro = await buscarAhorro(ID);
    corriente = await buscarCorriente(ID);
    saldo_total = await SaldoTotal(efectivo, corriente, ahorro);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  } on AuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Datos incorrectos porfavor intente de nuevo',
      style: TextStyle(fontFamily: fuente),
    )));

    debugPrint(e.message);
    debugPrint(e.statusCode);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Error al Logear usuario',
      style: TextStyle(fontFamily: fuente),
    )));
    debugPrint("error$e");
  }
}

Future<void> insertar(String correo, String pin, context) async {
  //final response = await supabase.auth.signUp(password: pin, email: correo);
  try {
    final response = await supabase.auth.signUp(password: pin, email: correo);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Usuario Registrado Exitosamente',
      style: TextStyle(fontFamily: fuente),
    )));
    controlerC.clear();
    controlerP.clear();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Home(),
      ),
    );
  } on AuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Error al registrar usuario, no acceso a la api',
      style: TextStyle(fontFamily: fuente),
    )));
    debugPrint(e.message);
    debugPrint(e.statusCode);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      'Error al registrar usuario',
      style: TextStyle(fontFamily: fuente),
    )));
    debugPrint("error$e");
  }
}
