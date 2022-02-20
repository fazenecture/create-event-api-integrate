import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:eventtask/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'event-type.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class CreateEvent extends StatelessWidget {
  static String id = 'create_event';
  File? _image;
  final picker = ImagePicker();
  final pickedImage = ImagePicker();


  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController startDateTime = TextEditingController();
  TextEditingController endDateTime = TextEditingController();
  DateTime dateTime = DateTime.now();
  var paths;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.keyboard_arrow_left),
        ),
        title:
            heading(context, text: "Create New Event", weight: FontWeight.w800),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async{
                  final pickedFile = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 59,
                  );
                  if (pickedFile != null) {
                    _image = File(pickedFile.path);
                    print("${pickedFile.path}");
                  } else {
                    print('No image selected');
                  }

                  var stream =
                  new http.ByteStream(DelegatingStream.typed(_image!.openRead()));
                  var length = await _image!.length();

                  var uri = Uri.parse("http://104.155.187.128:9999/api/upload");

                  var request = new http.MultipartRequest("POST", uri);
                  var multipartFile = new http.MultipartFile('file', stream, length,
                      filename: basename(_image!.path));
                  request.files.add(multipartFile);
                  var response = await request.send();
                  print(response.statusCode);
                  response.stream.transform(utf8.decoder).listen((value) {
                    var data = jsonDecode(value);
                    paths = data['path'].toString().substring(7);
                    print(paths);
                    String imageurl = 'http://104.155.187.128:9999/api/upload/$paths';
                    image.text = imageurl;
                  });

                },
                child: Container(
                  height: height * 0.25,
                  width: width,
                  decoration: BoxDecoration(
                      color: hexColor("F5F5F5"),
                      borderRadius: BorderRadius.circular(15)),
                  child: (Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      aimage("upload-file", scale: 2),
                      SBox(context, 0.015),
                      heading(context, text: "Upload your file here")
                    ],
                  )),
                ),
              ),
              SBox(context, 0.03),
              heading(context,
                  text: "Title",
                  weight: FontWeight.w500,
                  color: hexColor("565656")),
              SBox(context, 0.015),
              txtFieldContainer(
                context,
                controller: title,
                color: hexColor("f5f5f5"),
                borcolor: hexColor("F5F5F5"),
                hintText: "Type something",
                hintColor: Colors.black45,
              ),
              SBox(context, 0.03),
              heading(context,
                  text: "Descritpion",
                  weight: FontWeight.w500,
                  color: hexColor("565656")),
              SBox(context, 0.015),
              txtFieldContainer(context,
                  controller: description,
                  color: hexColor("f5f5f5"),
                  borcolor: hexColor("F5F5F5"),
                  hintText: "Type something",
                  hintColor: Colors.black45,
                  maxLines: 6),
              SBox(context, 0.03),
              button1(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SBox(context, 0.03),
                      heading(context, text: "Starting date and time"),
                      SBox(context, 0.02),
                      GestureDetector(
                        onTap: () async {
                          dateTimePicker(
                              context: context, startDateTime: startDateTime);
                        },
                        child: button1(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              heading(context, text: "Right after listing"),
                              Icon(Icons.keyboard_arrow_down_outlined)
                            ],
                          ),
                          10,
                          color: Colors.white,
                        ),
                      ),
                      SBox(context, 0.03),
                      heading(context, text: "Ending date and time"),
                      SBox(context, 0.02),
                      GestureDetector(
                        onTap: () async {
                          dateTimePicker(
                              context: context, startDateTime: endDateTime);
                        },
                        child: button1(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                heading(context, text: "1 Day"),
                                Icon(Icons.keyboard_arrow_down_outlined)
                              ],
                            ),
                            10,
                            color: Colors.white),
                      ),
                      SBox(context, 0.02),
                    ],
                  ),
                  15,
                  color: hexColor("F5F5F5")),
              SBox(context, 0.05),
              navigate(
                title: title,
                desc: description,
                startDateTime: startDateTime,
                endDateTime: endDateTime,
                image: image,
                context: context,
                page: EventType(),
                child: button1(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          heading(context,
                              text: "Next",
                              weight: FontWeight.w600,
                              color: Colors.white)
                        ],
                      ),
                    ),
                    15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
