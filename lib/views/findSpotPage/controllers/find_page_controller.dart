
import 'package:get/get.dart';

import '../../../dataBaseFiles/data_base_init.dart';

class FindPageController extends GetxController{

  RxList listOfSpots = [].obs;
  RxInt spotIndex = 0.obs;
  RxString finalAddress = ''.obs;

  void fetchAllData() async{
    List<Map<String, dynamic>> allData = await InitDataBase.instance.queryAll();
    listOfSpots.value = allData;
  }

}