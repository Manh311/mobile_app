import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter/foundation.dart';

class SignalRService {
  HubConnection? hub;

  Future<void> init(String token, {
    required Function(String, String) onNoti,
    required Function() onCalendar,
  }) async {
    hub = HubConnectionBuilder()
        .withUrl("http://10.0.2.2:5000/pcmhub", 
            options: HttpConnectionOptions(accessTokenFactory: () async => token))
        .withAutomaticReconnect()
        .build();

    hub?.on("ReceiveNotification", (args) => onNoti(args![0].toString(), args[1].toString()));
    hub?.on("UpdateCalendar", (args) => onCalendar());
    
    await hub?.start();
  }
}

  Future<void> initConnection({
    required Function(String title, String message) onNotification,
    required Function() onCalendarUpdate,
    required Function(dynamic data) onMatchScoreUpdate,
  }) async {
    try {
      // Initialize your SignalR connection here
      // Example: Connect to hub, set up listeners, etc.
      debugPrint('SignalR connection initialized');
    } catch (e) {
      debugPrint('SignalR connection error: $e');
    }
  }
