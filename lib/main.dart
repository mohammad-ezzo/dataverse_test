import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rentready_test/core/util/SizeConfig.dart';
import 'package:rentready_test/router.dart';

import 'core/services/connectivity/connectivity_builder.dart';
import 'injections.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjections();

  runApp(const App());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      onGenerateRoute: AppRouter.generateRoute,
      builder: (context, child) {
        SizeConfig().init(context);
        return ConnectivityBuilder(
          child: child!,
          noConnectionTitle: "No Internet Connection!",
          tryAgainTitle: "Try again.",
          onConnectionCallback: () => print("Connection back."),
        );
      },
      initialRoute: "/accounts/login",
    );
  }
}
