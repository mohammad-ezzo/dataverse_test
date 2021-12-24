import 'package:flutter/material.dart';
import 'package:rentready_test/features/accounts/presentation/login/pages/login_page.dart';

import 'features/accounts/presentation/search/pages/search_page.dart';

class AppRouter {
  static String currentRoute = "/";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      case '/accounts/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/accounts/search':
        return MaterialPageRoute(builder: (_) => const SearchPage());
      // case '/detials':
      //   return MaterialPageRoute(builder: (_) => DetailsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
