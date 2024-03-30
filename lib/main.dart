import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Compression App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VideoCompressionScreen(),
    );
  }
}

class VideoCompressionScreen extends StatefulWidget {
  @override
  _VideoCompressionScreenState createState() => _VideoCompressionScreenState();
}

class _VideoCompressionScreenState extends State<VideoCompressionScreen> {
  List<String> selectedVideos = [];
  String _outputDirectory = '';

  @override
  void initState() {
    super.initState();
    _outputDirectory = '${Directory.current.path}/Processed_videos';
  }

  Future<void> pickVideos() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: true,
      );
      if (result != null) {
        print('Files picked:');
        result.files.forEach((file) {
          print('Name: ${file.name}');
          print('Size: ${file.size}');
          print('-------------');
        });
        setState(() {
          selectedVideos = result.files.map((file) => file.path!).toList();
        });
      } else {
        print('No files picked.');
      }
    } catch (e) {
      print("Error while picking videos: $e");
    }
  }

  Future<void> processVideos(String mode) async {
    for (var i = 0; i < selectedVideos.length; i++) {
      final originalFileName = selectedVideos[i].split('/').last;
      final outputFileName = '$_outputDirectory/${originalFileName.split('.')[0]}_$mode.mp4';

      // Placeholder logic to demonstrate processing
      print('Processing $mode video: $originalFileName');
      // Simulate processing delay
      await Future.delayed(Duration(seconds: 2));
      print('Completed processing $mode video: $originalFileName');
      print('Output file: $outputFileName');
      print('-------------');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Compression App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async {
              await pickVideos();
            },
            child: Text('Select Videos'),
          ),
          ElevatedButton(
            onPressed: () => processVideos('compressed'),
            child: Text('Compress Videos'),
          ),
          ElevatedButton(
            onPressed: () => processVideos('decompressed'),
            child: Text('Decompress Videos'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedVideos.length,
              itemBuilder: (context, index) {
                String video = selectedVideos[index];
                return ListTile(
                  title: Text(video.split('/').last),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
