// import 'dart:io';

// import 'package:internet_connection_checker/internet_connection_checker.dart';

// abstract class NetworkInfo {
//   Future<bool> get isConnected;
// }

// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnectionChecker connectionChecker=Con;

//   NetworkInfoImpl(this.connectionChecker) {
//     connectionChecker.addresses = [
//       AddressCheckOptions(
//         InternetAddress(
//           '8.8.4.4', // Google
//           type: InternetAddressType.IPv4,
//         ),
//         port: 53,
//         timeout: Duration(seconds: 10),
//       )
//     ];
//   }

//   @override
//   Future<bool> get isConnected => connectionChecker.hasConnection;
// }
// // there is an option to register a listener for changes, but it is better to
// // trager it manualy