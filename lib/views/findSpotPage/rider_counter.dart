import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spots/views/findSpotPage/controllers/find_page_controller.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';

import '../../dataBaseFiles/data_base_init.dart';

class RiderCounter {

  NewSpotController newSpotController = Get.find();
  FindPageController findPageController = Get.find();

  void addRider(index){

    newSpotController.ridersCounter.value = findPageController.listOfSpots[index]['Riders_counter'];
    print(newSpotController.ridersCounter.value);

    InitDataBase.instance.update({
      InitDataBase.spotID: index+1,
      InitDataBase.ridersCounter: (newSpotController.ridersCounter.value + 1).toString(),
    });

  }

  void removeRider(index){

    newSpotController.ridersCounter.value = findPageController.listOfSpots[index]['Riders_counter'];
    InitDataBase.instance.update({
      InitDataBase.spotID: index+1,
      InitDataBase.ridersCounter: (newSpotController.ridersCounter.value - 1).toString(),
    });

  }

}

