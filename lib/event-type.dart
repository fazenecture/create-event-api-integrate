import 'package:eventtask/create-event.dart';
import 'package:eventtask/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class EventType extends StatelessWidget {
  static String id = 'event_type';

  TextEditingController eventType = TextEditingController();
  TextEditingController eventPrice = TextEditingController();
  TextEditingController eventLocation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final eventInfo = ModalRoute.of(context)!.settings.arguments as Map;
    String title = eventInfo['title'];
    String description = eventInfo['description'];
    String startDateTime = eventInfo['startDateTime'];
    String endDateTime = eventInfo['endDateTime'];
    String image = eventInfo['image'];

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.keyboard_arrow_left),
        ),
        title: heading(context, text: "Event type", weight: FontWeight.w800),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                button1(
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          heading(context, text: "Paid", color: Colors.white),
                          Icon(Icons.keyboard_arrow_down_outlined,
                              color: Colors.white)
                        ],
                      ),
                    ),
                    10,
                    color: hexColor("F2994A")),
                SBox(context, 0.04),
                button1(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SBox(context, 0.02),
                        heading(context,
                            text: "Enter the price of event", scale: 0.9),
                        txtFieldContainer(context,
                            color: hexColor("f5f5f5"),
                            borcolor: Colors.transparent,
                            hintText: "1232")
                      ],
                    ),
                    15,
                    color: hexColor("F5F5F5")),
                SBox(context, 0.04),
                button1(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SBox(context, 0.03),
                        heading(context, text: "Location"),
                        SBox(context, 0.02),
                        button1(
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  heading(context, text: "Remote"),
                                ],
                              ),
                            ),
                            10,
                            color: Colors.white),
                        SBox(context, 0.02),
                      ],
                    ),
                    15,
                    color: hexColor("F5F5F5")),
              ],
            ),
            button1(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      heading(context,
                          text: "Create New",
                          weight: FontWeight.w600,
                          color: Colors.white)
                    ],
                  ),
                ),
                15, onTap: () async {
              print(startDateTime);

              if (title.isNotEmpty &&
                  description.isNotEmpty &&
                  startDateTime.isNotEmpty &&
                  endDateTime.isNotEmpty) {
                String url =
                    'http://104.155.187.128:9999/api/upload/v1/event/updateEvent';
                Map<String, String> headers = {
                  "Content-Type": "application/json"
                };
                String json =
                    '{"id":1234, "creator": 3423, "type" : 1, "currency_type" :1,"location":"India","file":"${image}","title":"${title}","description":"${description}","start_at":"${startDateTime}", "end_at":"${endDateTime}"}';
                var response = await post(
                    Uri.parse(url),
                    headers: headers,
                    body: json);
                print(json);
                if(response.body != null || response.statusCode == 200){
                  print(response.body);
                  Navigator.pushReplacementNamed(context, CreateEvent.id);
                }else{
                  print("Error creating event");
                }

              } else {
                print("Error creating the event");
              }
            }),
          ],
        ),
      ),
    );
  }
}
