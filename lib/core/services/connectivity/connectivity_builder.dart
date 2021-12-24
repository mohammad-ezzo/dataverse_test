import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'connectivity_bloc/connectivity_bloc.dart';

class ConnectivityBuilder extends StatefulWidget {
  const ConnectivityBuilder(
      {Key? key,
      required this.child,
     
      required this.onConnectionCallback,
      required this.noConnectionTitle,
      required this.tryAgainTitle})
      : super(key: key);

  final Widget child;
 
  final Function() onConnectionCallback;
  final String noConnectionTitle;
  final String tryAgainTitle;

  @override
  _ConnectivityBuilderState createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends State<ConnectivityBuilder> {
  final ConnectivityBloc _connectivityBloc = ConnectivityBloc();
  @override
  void initState() {
    super.initState();
    _connectivityBloc.add(CheckConnectivity());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _connectivityBloc,
      listener: (context, state) {
        if (state is Connected) {
          widget.onConnectionCallback();
        }
      },
      builder: (context, state) {
        if (state is NotConnected) {
          return Stack(
            children: [
              widget.child,
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.black26,
                child: Center(
                  child: AlertDialog(
                      backgroundColor: Colors.white,
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * .32,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/noInternet.png",
                                height: 200,
                              ),
                            ],
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("  " + widget.noConnectionTitle,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04)),
                            ],
                          ),
                        ]),
                      )),
                ),
              )
            ],
          );
        }
        return widget.child;
      },
    );
  }
}
