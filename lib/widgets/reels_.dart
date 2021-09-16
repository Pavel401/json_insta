  
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
class reels extends StatefulWidget {
  const reels({Key? key}) : super(key: key);

  @override
  _reelsState createState() => _reelsState();
}

class _reelsState extends State<reels> {
  var url;
  var video_url;

  final TextEditingController _mycontroller = new TextEditingController();
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    // String str= url.replaceAll('utm_source=ig_web_copy_link', '__a=1');
    //String url = _mycontroller.text;
    String link1 = " ";
    download() async {
      int randomNumber = random.nextInt(4987536); // from 0 upto 99 included

      var status = await Permission.storage.request();
      if (status.isGranted) {
        print('PERMISSION GRANTED');

    
    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";
    await Dio().download(video_url, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'File is downloaded in +$result',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } else {
        print('PERMISSION NOT GRANTED');
      }
    }

    getData() async {
      if (_mycontroller.text.endsWith('utm_medium=copy_link')) {
        url = _mycontroller.text.replaceAll('utm_medium=copy_link', '__a=1');
      } else if ((_mycontroller.text.endsWith('utm_source=ig_web_copy_link'))) {
        url = _mycontroller.text
            .replaceAll('utm_source=ig_web_copy_link', '__a=1');
      }

      final response = await http.get(
        Uri.parse(url),
      );
      var jsonData = jsonDecode(response.body);
      print(response.body);
      var graphql = jsonData['graphql'];
      var shortcodeMedia = graphql['shortcode_media'];
      video_url=shortcodeMedia['video_url'];
      
  print(video_url);
      //_TypeError (type 'List<dynamic>' is not a subtype of type 'String')

     
      download();
      return null;
    }

    stringCheck() {
      if (_mycontroller.text.endsWith('utm_medium=copy_link')) {
        getData();
      } else if ((_mycontroller.text.endsWith('utm_source=ig_web_copy_link'))) {
        getData();
      }
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 100),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/logo.png',
              height: 150,
              width: 150,
            ),
          ),
          Container(
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(8),
                      child: TextField(
                        controller: _mycontroller,
                        decoration: InputDecoration(
                          hintText: 'Enter The Link',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.download_outlined),
                      label: Text("Download Reels"),
                      onPressed: () => {
                        print('ok'),
                        // print(_mycontroller.text),
                        //ScaffoldMessenger.of(context).showSnackBar(
                        // SnackBar(
                        // content: Text(_mycontroller.text,style: TextStyle(color: Colors.white),),
                        // ),
                        //  ),
                        stringCheck(),

                        //print(str),

                        //Navigator.push(
                        // context,
                        //MaterialPageRoute(
                        //builder: (context) => DownloadPage(
                        //   data: link1,
                        //)),
                        // ),
                        
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}