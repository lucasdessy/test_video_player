import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

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
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  late TextEditingController _inputController;

  @override
  void initState() {
    _inputController = TextEditingController();
    super.initState();
  }

  Future<void> _initVideo() async {
    final videoUrl = _inputController.text;
    if (videoUrl.isEmpty) {
      return;
    }
    _controller?.dispose();
    _chewieController?.dispose();

    _controller = null;
    _chewieController = null;

    _controller = VideoPlayerController.network(
      videoUrl,
    );
    log("Initializing video player...");
    await _controller!.initialize();
    _chewieController = _chewieController = ChewieController(
      videoPlayerController: _controller!,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      fullScreenByDefault: true,
      allowedScreenSleep: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
      errorBuilder: (context, errorMessage) {
        return const Center(
          child: Text(
            "Ocorreu um erro ao carregar o vídeo.",
          ),
        );
      },
    );
    log("Video player initialized");
    setState(() {});
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
            onSubmitted: (_) {
              _initVideo();
            },
          ),
          ElevatedButton(
            onPressed: () {
              _initVideo();
            },
            child: const Text('Play'),
          ),
          if (_chewieController != null)
            AspectRatio(
              aspectRatio:
                  _chewieController!.videoPlayerController.value.aspectRatio,
              child: Chewie(
                controller: _chewieController!,
              ),
            ),
        ],
      ),
    );
  }
}
