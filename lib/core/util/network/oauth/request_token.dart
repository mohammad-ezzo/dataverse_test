import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rentready_test/core/util/network/oauth/token.dart';
import 'package:rentready_test/core/util/network/oauth/token_request_details.dart';

import '../../../../injections.dart';
import 'config.dart';

class RequestToken {
  final Config config;

  RequestToken(this.config);

  Future<Token> requestToken(String code) async {
    final _tokenRequest = TokenRequestDetails(config, code);
    return await _sendTokenRequest(
        _tokenRequest.url, _tokenRequest.params, _tokenRequest.headers);
  }

  Future<Token> _sendTokenRequest(String url, Map<String, String> params,
      Map<String, String> headers) async {
    var response = await sl<Dio>().post((url),
        data: params,
        options: Options(contentType: "application/x-www-form-urlencoded"));
    final tokenJson = (response.data);
    if (tokenJson is Map<String, dynamic>) {
      var token = Token.fromJson(tokenJson);
      return token;
    }
    throw ArgumentError('Token json is invalid');
  }
}
