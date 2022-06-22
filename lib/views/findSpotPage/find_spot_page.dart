import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:skate_spots/dataBaseFiles/data_base_init.dart';
import 'package:skate_spots/views/findSpotPage/rider_counter.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skate_spots/views/detailSpotPage/controllers/detail_spot_controller.dart';
import 'package:skate_spots/views/findSpotPage/controllers/find_page_controller.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sliding_switch/sliding_switch.dart';

import '../../image_picker.dart';

final sliderState = GetStorage();

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

                          Row(
                            children: [
                              Text('Now riding : '),
                              Text(findPageController.listOfSpots[index]['Riders_counter'].toString())
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    // print(findPageController.listOfSpots[index]['Spot_images'].split(', '));
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
                              SizedBox(width: 10.0,),
                              SlidingSwitch(
                                value: sliderState.read(findPageController.listOfSpots[index]['_id'].toString()),
                                width: 150,
                                onChanged: (bool value) {
                                  sliderState.write(findPageController.listOfSpots[index]['_id'].toString(), value);
                                  if(sliderState.read(findPageController.listOfSpots[index]['_id'].toString()) == true){

                                    RiderCounter().addRider(index);
                                    // newSpotController.ridersCounter.value = findPageController.listOfSpots[index]['Riders_counter'];
                                    // print(newSpotController.ridersCounter.value);
                                    //
                                    // InitDataBase.instance.update({
                                    //   InitDataBase.spotID: index+1,
                                    //   InitDataBase.ridersCounter: (newSpotController.ridersCounter.value + 1).toString(),
                                    // });

                                  }else{
                                    if(findPageController.listOfSpots[index]['Riders_counter'] > 0){

                                      RiderCounter().removeRider(index);
                                      // newSpotController.ridersCounter.value = findPageController.listOfSpots[index]['Riders_counter'];
                                      // InitDataBase.instance.update({
                                      //   InitDataBase.spotID: index+1,
                                      //   InitDataBase.ridersCounter: (newSpotController.ridersCounter.value - 1).toString(),
                                      // });
                                    }
                                  }
                                  // print(value);
                                  // print(sliderState.read(findPageController.listOfSpots[index]['_id']));
                                },
                                height : 35,
                                animationDuration : const Duration(milliseconds: 400),
                                onTap:(){},
                                onDoubleTap:(){},
                                onSwipe:(){},
                                textOff : "Busted",
                                textOn : "Riding",
                                colorOn : Colors.green,
                                colorOff : Colors.red,
                                background : const Color(0xffe4e5eb),
                                buttonColor : const Color(0xfff7f5f7),
                                inactiveColor : const Color(0xff636f7b),
                              ),

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
