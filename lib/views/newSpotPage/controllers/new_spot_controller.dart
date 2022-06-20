import 'package:get/get.dart';
import 'package:skate_spots/models/skate_spot_model.dart';
import '../../../dataBaseFiles/data_base_init.dart';
import '../../../models/skate_spot_model.dart';
import 'package:collection/collection.dart';

class NewSpotController extends GetxController {
  RxString spotName = ''.obs;
  RxString spotDescription = ''.obs;
  RxList spotProperties = [].obs;
  RxList spotImages = [].obs;

  RxString countryName = ''.obs;
  RxString postalCode = ''.obs;
  RxString cityName = ''.obs;
  RxString streetName = ''.obs;
  RxString streetNumber = ''.obs;
  RxInt voteCounter = 0.obs;
  RxInt ratingSum = 0.obs;
  RxInt finalRating = 0.obs;


  void addSpot() async {
    SpotModel newSpot = SpotModel(
        spotName: spotName.value,
        spotDescription: spotDescription.value,
        spotProperties: spotProperties.value,
        address: Address(
            countryName: countryName.value,
            cityName: cityName.value,
            postalCode: postalCode.value,
            streetName: streetName.value,
            streetNumber: streetNumber.value),
        voteCounter: voteCounter.value,
        ratingSum: ratingSum.value,
        finalRating: finalRating.value,
        spotImages: spotImages.value);

    await InitDataBase.instance.insert({
      InitDataBase.spotName: newSpot.spotName,
      InitDataBase.spotProperties: newSpot.spotProperties?.join(', '),
      InitDataBase.spotDescription: newSpot.spotDescription,
      InitDataBase.countryName: newSpot.address?.countryName,
      InitDataBase.cityName: newSpot.address?.cityName,
      InitDataBase.postalCode: newSpot.address?.postalCode,
      InitDataBase.streetName: newSpot.address?.streetName,
      InitDataBase.streetNumber: newSpot.address?.streetNumber,
      InitDataBase.voteCounter: newSpot.voteCounter,
      InitDataBase.ratingSum: newSpot.ratingSum,
      InitDataBase.finalRating: newSpot.finalRating,
      InitDataBase.spotImages: newSpot.spotImages?.join(', '),

      // InitDataBase.spotLatitude: newSpot.geoPosition?.spotLatitude,
      // InitDataBase.spotLongitude: newSpot.geoPosition?.spotLongitude,
    });
  }
}
