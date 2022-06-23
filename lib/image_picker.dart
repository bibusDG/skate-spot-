
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io'as Io;
import 'package:skate_spots/views/findSpotPage/controllers/find_page_controller.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';

class ImagesFromCamera {

  FindPageController findPageController = Get.find();
  NewSpotController newSpotController = Get.find();

  Future imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final finalImage = image.toString();
    print(finalImage);

    // InitDataBase.instance.update({
    //   InitDataBase.spotID: findPageController.spotIndex.value+1,
    //   InitDataBase.spotImages: finalImage,
    // });
  }

  Future imageFromCamera() async {

    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final finalImage = Io.File(image.path);


    final bytes = finalImage.readAsBytesSync();
    String img64 = base64Encode(bytes);


    newSpotController.spotImages.add(img64);
    newSpotController.photoCounter.value--;
    // print(newSpotController.spotImages.length);


    // InitDataBase.instance.update({
    //   InitDataBase.spotID: findPageController.spotIndex.value+1,
    //   InitDataBase.spotImages: newSpotController.spotImages.join(', '),
    // });
  }
}
