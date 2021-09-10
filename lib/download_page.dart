import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_insta/colors.dart';
import 'package:permission_handler/permission_handler.dart';

//Old Method Now its unusefull
class DownloadPage extends StatefulWidget {
  final String data;
  const DownloadPage({required this.data,Key? key}) : super(key: key);

  @override
  _DownloadPageState createState() => _DownloadPageState(data);
}

class _DownloadPageState extends State<DownloadPage> {
  final String data;
  _DownloadPageState(this.data);

  String link = 
      "https://instagram.frdp1-1.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/241363181_1284692995281987_6985371816854126879_n.jpg?_nc_ht=instagram.frdp1-1.fna.fbcdn.net&_nc_cat=103&_nc_ohc=xn4T1t6byRoAX_FWhms&edm=AABBvjUBAAAA&ccb=7-4&oh=6d3d119031b85b627a6963727bcde4fb&oe=613FC0F0&_nc_sid=83d603";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colour1,
              color2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(style: BorderStyle.solid, width: 2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    child: Image.network(link),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                print('hello');

                var status = await Permission.storage.request();
                if (status.isGranted) {
                  print('PERMISSION GRANTED');
                  var response = await Dio().get(data,
                      options: Options(responseType: ResponseType.bytes));
                  final result = await ImageGallerySaver.saveImage(
                      Uint8List.fromList(response.data),
                      quality: 60,
                      name: 'hello');
                  print(result);
                } else {
                  print('PERMISSION NOT GRANTED');
                }
              },
              icon: Icon(
                Icons.save_alt_outlined,
                color: Colors.blue,
              ),
              label: Text(
                'Save To Device',
                style: TextStyle(color: Colors.blue),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(width: 2.0, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
