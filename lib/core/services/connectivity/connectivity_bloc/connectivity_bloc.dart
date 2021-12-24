import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscribtion;

  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectedEvent>((event, emit) => emit(Connected()));
    on<NotConnectedEvent>((event, emit) {
      if (state is! NotConnected) emit(NotConnected());
    });
  }

  @override
  Future<void> close() {
    connectivitySubscribtion?.cancel();
    return super.close();
  }

  _onCheckConnectivity(
      CheckConnectivity event, Emitter<ConnectivityState> emit) async {
    emit(ConnectivityInitial());
    await initConectivity();
  }

  initConectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();

      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(ConnectedEvent());
      } else {
        add(NotConnectedEvent());
      }

      connectivitySubscribtion ??=
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } on PlatformException catch (e) {
      print(e.toString());
      add(NotConnectedEvent());
    }
  }

  _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        if (state is NotConnected) {
          add(ConnectedEvent());
        }
        break;
      default:
        if (state is Connected) {
          add(NotConnectedEvent());
        }
        break;
    }
  }
}
