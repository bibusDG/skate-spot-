import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skate_spots/models/skate_spot_model.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';

class GeoLocation {

  NewSpotController newSpotController = Get.find();

  /// GEOLOCATION SETUP
  ///
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Get.snackbar('GPS position', 'Position successfully reached');
    return await Geolocator.getCurrentPosition();

  }

  void finalPosition()async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    // newSpotController.countryName =
    print(position);
    print(placemarks[0]);
    print(placemarks[0].toString().split(',')[0].split(':')[1]);

    newSpotController.countryName.value = placemarks[0].toString().split(',')[3].split(':')[1];
    newSpotController.cityName.value = placemarks[0].toString().split(',')[7].split(':')[1];
    newSpotController.postalCode.value = placemarks[0].toString().split(',')[4].split(':')[1];
    newSpotController.streetName.value = placemarks[0].toString().split(',')[9].split(':')[1];
    newSpotController.streetNumber.value = placemarks[0].toString().split(',')[0].split(':')[1];

  }

  get determinePosition => _determinePosition();
}

