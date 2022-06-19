import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:skate_spots/dataBaseFiles/data_base_init.dart';
import 'package:skate_spots/views/detailSpotPage/detail_spot_page.dart';
import 'package:skate_spots/views/findSpotPage/find_spot_page.dart';
import 'package:skate_spots/views/mainPage/main_page.dart';
import 'package:skate_spots/views/newSpotPage/new_spot_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // InitDataBase newDataBase = InitDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      getPages: [
        GetPage(name: '/', page: () => MainPage()),
        GetPage(name: '/newSpot', page: () => NewSpotPage()),
        GetPage(name: '/findSpot', page: () => FindSpotPage()),
        GetPage(name: '/detailSpot', page: () => DetailSpotPage()),
      ],
    );
  }
}
