import 'dart:typed_data'; // Add this import statement for Uint8List

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
  List<Uint8List> selectedVideos = []; // Use Uint8List type for selectedVideos

  // Function to pick videos
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
          // Use bytes property instead of path on web
          print('Bytes length: ${file.bytes!.length}');
          print('-------------');
        });
        // Use bytes property instead of path on web
        setState(() {
          selectedVideos = result.files.map((file) => file.bytes!).toList();
        });
      } else {
        print('No files picked.');
      }
    } catch (e) {
      print("Error while picking videos: $e");
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
            onPressed: pickVideos,
            child: Text('Select Videos'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedVideos.length,
              itemBuilder: (context, index) {
                final video = selectedVideos[index];
                return ListTile(
                  title: Text('Video ${index + 1}'),
                  subtitle: Text('Size: ${video.length} bytes'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
