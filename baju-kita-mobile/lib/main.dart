import 'package:bajukita/data/static.dart';
import 'package:bajukita/repository/auth_repository.dart';
import 'package:bajukita/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initialData();

  runApp(const MyApp());
}

Future<void> _initialData() async {
  var pref = await SharedPreferences.getInstance();

  if (pref.containsKey('token')) {
    var token = pref.getString('token');

    DataStatic.token = token;
    DataStatic.user = await AuthRepository().user().catchError((err) {
      if (kDebugMode) {
        print(err);
      }
    });

    if (DataStatic.user == null) {
      DataStatic.token = null;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BAJUKITA',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.white,
        ),
      ),
      initialRoute: Routes.splash,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
