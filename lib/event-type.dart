import 'package:eventtask/styles.dart';
import 'package:flutter/material.dart';

class EventType extends StatelessWidget {
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
                15),
          ],
        ),
      ),
    );
  }
}
