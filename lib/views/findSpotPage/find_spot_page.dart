import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skate_spots/views/detailSpotPage/controllers/detail_spot_controller.dart';
import 'package:skate_spots/views/findSpotPage/controllers/find_page_controller.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../image_picker.dart';

class FindSpotPage extends StatelessWidget {
  const FindSpotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FindPageController findPageController = Get.find();
    NewSpotController newSpotController = Get.find();
    DetailSpotController detailSpotController = Get.find();

    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: findPageController.listOfSpots.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 200.0,
              child: Card(
                child: Row(
                  children: [
                    SizedBox(
                      width: 20.0,

                    ),
                    Obx(()=>Expanded(
                        flex: 1,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            findPageController.listOfSpots[index]['Spot_images'].split(', ')[0] != '' ?
                              Image.memory(base64Decode(findPageController.listOfSpots[index]['Spot_images'].split(', ')[0])) : Text('No image'),

                            // Image.memory(base64Decode(findPageController.listOfSpots[index]['Spot_images'].split(', ')[0])),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Spot name : ${findPageController.listOfSpots[index]['Spot_name']}'),
                          Text('City : ${findPageController.listOfSpots[index]['City_name']}'),
                          Text('Street : ${findPageController.listOfSpots[index]['Street_name']}'),
                          Row(
                            children: [
                              Text('Rating : '),
                              for (var i = 0; i < findPageController.listOfSpots[index]['Final_Rating']; i++)
                                Icon(Icons.skateboarding)
                            ],
                          ),

                          Text('Now riding : '),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    print(findPageController.listOfSpots[index]['Spot_images'].split(', '));
                                    findPageController.spotIndex.value = index;

                                    Get.toNamed('/detailSpot');

                                    // findPageController.finalAddress.value = findPageController.listOfSpots[index]['Country_name']+', '+findPageController.listOfSpots[index]['City_name']+
                                    // ', '+ findPageController.listOfSpots[index]['Postal_code']+', '+findPageController.listOfSpots[index]['Street_name']+' '+
                                    // findPageController.listOfSpots[index]['Street_number'];

                                    findPageController.finalAddress.value = [
                                      findPageController.listOfSpots[index]['Country_name'],
                                      findPageController.listOfSpots[index]['City_name'],
                                      findPageController.listOfSpots[index]['Postal_code'],
                                      findPageController.listOfSpots[index]['Street_name'],
                                      findPageController.listOfSpots[index]['Street_number']
                                    ].join(' ');
                                  },
                                  child: Text('Details')),

                            ],
                          ),
                          // ElevatedButton(onPressed: () async{
                          //

                          //   print(finalAddress);
                          //   if (!await launchUrl(Uri.parse('https://www.google.pl/maps/search/$finalAddress/'))) throw 'Could not launch';
                          // }, child: Text('Check spot on map'))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
