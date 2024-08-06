import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlashlightPage extends StatefulWidget {
  const FlashlightPage({super.key});

  @override
  _FlashlightPageState createState() => _FlashlightPageState();
}

class _FlashlightPageState extends State<FlashlightPage> {
  static const platform =
      MethodChannel('com.example.flashlight_app/flashlight');
  bool isFlashlightOn = false;

  Future<void> _toggleFlashlight() async {
    try {
      if (isFlashlightOn) {
        await platform.invokeMethod('turnOffFlashlight');
      } else {
        await platform.invokeMethod('turnOnFlashlight');
      }
      setState(() {
        isFlashlightOn = !isFlashlightOn;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to toggle flashlight: ${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isFlashlightOn ? Colors.yellow : Colors.white,
      appBar: AppBar(
        title: const Text('Flashlight'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () async {
                    await _toggleFlashlight();
                  },
                  icon: Icon(
                    isFlashlightOn ? Icons.flashlight_on : Icons.flashlight_off,
                    size: 200,
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
