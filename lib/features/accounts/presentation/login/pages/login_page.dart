import 'package:flutter/material.dart';
import 'package:rentready_test/constants.dart';
import 'package:rentready_test/core/util/network/oauth/config.dart';
import 'package:rentready_test/core/util/network/oauth/request_code.dart';
import 'package:rentready_test/core/util/network/oauth/request_token.dart';
import 'package:rentready_test/core/util/network/oauth/token.dart';
import 'package:rentready_test/features/accounts/data/data_sources/accounts_api.dart';

import '../../../../../injections.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: _performFullAuthFlow,
              child: const Text("Sign in to Microsoft Account"))),
    );
  }

  Future<void> _performFullAuthFlow() async {
    try {
      final Config config = Config(
          clientSecret: appSecret,
          tenant: tenant,
          clientId: clientId,
          scope: "openid profile offline_access",
          redirectUri: redirectUri);
      RequestCode _requestCode = RequestCode(config);
      var code = await _requestCode.requestCode();
      if (code == null) {
        throw Exception('Access denied or authentication canceled.');
      }
      RequestToken _requestToken = RequestToken(config);
      final token = await _requestToken.requestToken(code);
      sl<AccountsApi>().addTokenToHeader(token.accessToken ?? "");
      Navigator.pushReplacementNamed(context, "/accounts/search");
    } catch (e) {}
  }
}
