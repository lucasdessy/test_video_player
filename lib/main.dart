import 'package:flutter/material.dart';
import 'package:lecle_yoyo_player/lecle_yoyo_player.dart';

// // String userAgent =
// // "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.3 Safari/605.1.15";
// String userAgent = "curl/7.86.0";
void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late TextEditingController _inputController;

  String? _videoUrl;

  @override
  void initState() {
    _inputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chewie Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _inputController,
            decoration: const InputDecoration(
              hintText: 'Enter video URL',
            ),
            onSubmitted: (value) {
              setState(() {
                _videoUrl = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _videoUrl = _inputController.text;
              });
            },
            child: const Text('Play'),
          ),
          if (_videoUrl != null && _videoUrl!.isNotEmpty)
            YoYoPlayer(
              aspectRatio: 16 / 9,
              url: _videoUrl!,
              videoStyle: const VideoStyle(),
              videoLoadingStyle: const VideoLoadingStyle(),
            ),
        ],
      ),
    );
  }
}
