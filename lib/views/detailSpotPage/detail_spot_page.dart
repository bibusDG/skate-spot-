import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spots/dataBaseFiles/data_base_init.dart';
import 'package:skate_spots/views/detailSpotPage/controllers/detail_spot_controller.dart';
import 'package:skate_spots/views/findSpotPage/controllers/find_page_controller.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailSpotPage extends StatelessWidget {
  const DetailSpotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FindPageController findPageController = Get.find();
    NewSpotController newSpotController = Get.find();
    DetailSpotController detailSpotController = Get.find();


    // findPageController.listOfSpots[index]['Spot_images'].split(', ')[0] != '' ?
    // Image.memory(base64Decode(findPageController.listOfSpots[index]['Spot_images'].split(', ')[0])) : Text('No image'),

    // GalleryImage(imageUrls: ['https://quartersnacks.com/wp-content/uploads/2011/08/brickbanks.jpg',
    // 'https://quartersnacks.com/wp-content/uploads/2011/08/bank1.jpg','https://quartersnacks.com/wp-content/uploads/2011/08/B.jpg'], numOfShowImages: 3,),



    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leadingWidth: double.maxFinite,
          leading: Builder(builder: (BuildContext context){
            return Row(
              children: [
                SizedBox(width: 15.0,),
                GestureDetector(child: Icon(Icons.home_outlined), onTap: (){Get.toNamed('/');},),
                SizedBox(width: 60,),
                GestureDetector(child: Icon(Icons.add), onTap: (){Get.toNamed('/newSpot');},),
              ],
            );
          }
          ),
        ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(flex:1,
                child:PageView(
                  controller: PageController(
                    viewportFraction: 0.6,
                  ),
                  children: [
                  for (var image in findPageController.listOfSpots[findPageController.spotIndex.value]['Spot_images'].split(', '))
                    image != '' ? Image.memory(base64Decode(image)) : Center(child: Icon(size:70.0, Icons.no_photography_outlined)),
                    // Image.memory(base64Decode(image)),


                ],),
    ),
              Expanded(flex:2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Spot name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                SizedBox(height: 10.0,),
                                Text(findPageController.listOfSpots[findPageController.spotIndex.value]['Spot_name']),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Spot description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                SizedBox(height: 10.0,),
                                Text(findPageController.listOfSpots[findPageController.spotIndex.value]['Spot_description']),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Spot properties', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                SizedBox(height: 10.0,),
                                Text(findPageController.listOfSpots[findPageController.spotIndex.value]['Spot_properties']),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Full address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                SizedBox(height:10.0),
                                Text(findPageController.finalAddress.value),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(onPressed: ()async{
                        if (!await launchUrl(Uri.parse('https://www.google.pl/maps/search/${findPageController.finalAddress.value}/'))) throw 'Could not launch';
                      }, child: Text('Find on map')),
                      ElevatedButton(onPressed: () async{
                        detailSpotController.voteCounter.value = findPageController.listOfSpots[findPageController.spotIndex.value]['Vote_counter'];
                        detailSpotController.ratingSum.value = findPageController.listOfSpots[findPageController.spotIndex.value]['Rating_sum'];

                        Get.defaultDialog(
                          title: 'Vote for spot',
                          content: RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.skateboarding,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              detailSpotController.rating.value = rating.toInt();
                              // print(rating);
                            },
                          ),
                          onConfirm: ()
                          async{
                            int newVoteCounter = detailSpotController.voteCounter.value+1;
                            int newRatingSum = detailSpotController.ratingSum.value + detailSpotController.rating.value;

                            // print(findPageController.spotIndex.value);
                            // detailSpotController.voteCounter.value = findPageController.listOfSpots[findPageController.spotIndex.value]['Vote_counter'];
                            // detailSpotController.ratingSum.value = findPageController.listOfSpots[findPageController.spotIndex.value]['Rating_sum'];

                            await InitDataBase.instance.update({
                              InitDataBase.spotID: findPageController.spotIndex.value+1,
                              InitDataBase.voteCounter: newVoteCounter,
                              InitDataBase.ratingSum: newRatingSum,
                              InitDataBase.finalRating: newRatingSum/newVoteCounter,

                            });
                            // print(detailSpotController.voteCounter.value);
                            // print(detailSpotController.ratingSum.value);
                            // print(detailSpotController.calculateFinalRating());
                            // print(findPageController.listOfSpots[findPageController.spotIndex.value]['Rating_sum']);
                            // print(findPageController.listOfSpots[findPageController.spotIndex.value]['Final_rating']);
                            // print(findPageController.listOfSpots.value);
                            findPageController.fetchAllData();
                            Get.toNamed('/findSpot');
                          },
                        );
                      }, child: Text('Vote'))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
