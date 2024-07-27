import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  bool showSpinner = false;

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print('No Image Selected.');
    }
  }

  Future<void> uploadImage() async {
    if (image == null) return;

    setState(() {
      showSpinner = true;
    });

    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";

    var multiPart = http.MultipartFile('image', stream, length);
    request.files.add(multiPart);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image Uploaded.');
    } else {
      print('Image Upload Failed.');
    }

    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('POST API IMAGE UPLOADER'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: getImage,
              child: Container(
                child: image == null
                    ? Center(
                  child: Text('Pick Image'),
                )
                    : Center(
                  child: Image.file(
                    File(image!.path).absolute,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 150),
            GestureDetector(
              onTap: uploadImage,
              child: Container(
                height: 50,
                color: Colors.blueAccent,
                child: Center(
                  child: Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
