import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/view%20models/controllers/general_controller.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ScreenMonitoringPage extends StatefulWidget {
  final String socketUrl;
  final String targetId;

  const ScreenMonitoringPage({
    super.key,
    required this.targetId,
    required this.socketUrl,
  });

  @override
  State<ScreenMonitoringPage> createState() => _ScreenMonitoringPageState();
}

class _ScreenMonitoringPageState extends State<ScreenMonitoringPage> {
  late WebSocketChannel _channel;
  bool _isInitialized = false;

  GeneralController generalController = Get.put(GeneralController());

  @override
  void initState() {
    super.initState();
    _channel = WebSocketChannel.connect(Uri.parse(widget.socketUrl));
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    generalController.stopScreenMonitoring(widget.targetId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen Monitoring"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Center(
          child: _isInitialized
              ? StreamBuilder<Uint8List>(
                  stream: _channel.stream.map((data) {
                    // Ensure the incoming data is Uint8List
                    if (data is Uint8List) {
                      return data;
                    } else {
                      throw Exception("Unexpected data format");
                    }
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return const Center(
                        child: Text("Connection Closed! Try again"),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No data received"),
                      );
                    }
                    return Image.memory(
                      snapshot.data!,
                      gaplessPlayback: true,
                    );
                  },
                )
              : const Text("Initiate Connection"),
        ),
      ),
    );
  }
}
