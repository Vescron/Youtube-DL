// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


TextEditingController myController = TextEditingController();

class _HomeState extends State<Home> {

  int progress = 0;
  bool isDisabled = false;

  Future<void> downloader(context) async {
    var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) { 
        // If not we will ask for permission first 
        await Permission.manageExternalStorage.request(); 
      }
    try{ 
      // ignore: unused_local_variable
      var manifest = await YoutubeExplode().videos.streamsClient.getManifest(myController.text.trim());
    } catch (e) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentTextStyle: TextStyle(color: Colors.white),
            elevation: 20,
            backgroundColor: Colors.blueGrey[700],
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.yellowAccent.shade100, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            icon: Icon(Icons.error, color: Colors.red, size: 50,),
            content:
                Text('Error: $e'),
          );
        }  
      );
      return;
    }
    setState(() {
    isDisabled = true;
    });
    var manifest = await YoutubeExplode().videos.streamsClient.getManifest(myController.text.trim());
    //print(manifest);
    var stream = manifest.muxed.withHighestBitrate();
    //Directory _dir = await getApplicationDocumentsDirectory();
    var video = await YoutubeExplode().videos.get(myController.text.trim());
    var filePath ='${video.title.substring(0,5)}.${stream.container.name}';
    if (Platform.isAndroid) { 
        // Redirects it to download folder in android 
      filePath = "/storage/emulated/0/Download/${video.title.substring(0,5)}.${stream.container.name}"; 
    }
    // Open the file to write.
    //Directory(filePath).create(recursive: true);
    var file = File(filePath);
    if (file.existsSync()) {
      file.deleteSync();
    }
    final fileStream = file.openWrite();
    final videoStream = YoutubeExplode().videos.streamsClient.get(stream);
    final len = stream.size.totalBytes;
    var count = 0;

    await for (final data in videoStream) {
      // Keep track of the current downloaded data.
      count += data.length;
      
      setState(() {
        progress = ((count/len)*100).ceil();
      });
      fileStream.add(data);
    }
    
    //await fileStream.flush();
    await fileStream.close();
    setState(() {
    isDisabled = false;
    progress = 0;
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentTextStyle: TextStyle(color: Colors.white),
          elevation: 20,
          backgroundColor: Colors.blueGrey[700],
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.yellowAccent.shade100, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          icon: Icon(Icons.done_all, color: Colors.green, size: 50,),
          content:
              Text('Download completed and saved to: $filePath'),
        );
      }
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 172, 172),
              borderRadius: BorderRadius.circular(20),
            ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Youtube DL',
              style: TextStyle(
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,),
              ),
              TextField(
                style: TextStyle(color: Colors.white,
                shadows: [Shadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 0))]),
                decoration: InputDecoration(
                  hintText: 'Enter URL',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                controller: myController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: isDisabled ? null : () {downloader(context);},
                   child: Text('Download')),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Progress $progress%...'),
                  ),
                ],
              ),

            ],
          ),
        )
        ),
        backgroundColor: Color(0xFFe3dcc2),
    );
  }
}