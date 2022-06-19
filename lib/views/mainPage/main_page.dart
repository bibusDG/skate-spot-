import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spots/dataBaseFiles/data_base_init.dart';
import 'package:skate_spots/models/skate_spot_model.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';

import '../detailSpotPage/controllers/detail_spot_controller.dart';
import '../findSpotPage/controllers/find_page_controller.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FindPageController findPageController = Get.put(FindPageController());
    NewSpotController spotController = Get.put(NewSpotController());
    DetailSpotController detailSpotController = Get.put(DetailSpotController());

    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;

    return
      SafeArea(
          child:Stack(children: [
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/backgrounds/skateboard.jpg"),
                      fit: BoxFit.cover,
                    ))),
            Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text('ABOUT APP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(children:[
                      SizedBox(height: 180,),

                      Row(
                        children: [

                          SizedBox(width: 100.0,),
                          GestureDetector(
                            onTap: () async{
                              Get.toNamed('/newSpot');
                            // SpotModel newSpot = SpotModel(
                            //     spotName: 'Kwidzyn',
                            //     spotProperties: ['rails', 'banks', 'stairs'],
                            //     geoPosition: GeoPosition(spotLatitude: 'xx', spotLongitude: 'ii'));
                            //
                            // await InitDataBase.instance.insert({
                            //   InitDataBase.spotName: newSpot.spotName,
                            //   InitDataBase.spotProperties: newSpot.spotProperties.join(','),
                            //   InitDataBase.spotLatitude: newSpot.geoPosition?.spotLatitude,
                            //   InitDataBase.spotLongitude: newSpot.geoPosition?.spotLongitude,
                            // });

                            },
                              child: Text('Add new spot ',
                                  style:TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      SizedBox(height: 100,),
                      Row(
                        children: [
                          SizedBox(width: 60.0,),
                          GestureDetector(
                            onTap: ()async{
                              List<Map<String, dynamic>> allData = await InitDataBase.instance.queryAll();
                              findPageController.listOfSpots.value = allData;
                              print(allData);
                              Get.toNamed('/findSpot');
                            },
                              child: Text('Find spot ',
                                  style:TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.bold))),
                        ],
                      ),

                    ]),
                ),
            ),

          ]),
        );
  }
}
