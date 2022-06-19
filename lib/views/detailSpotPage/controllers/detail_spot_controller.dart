import 'package:get/get.dart';

class DetailSpotController extends GetxController{

  RxInt voteCounter = 0.obs;
  RxInt ratingSum = 0.obs;
  RxInt rating = 0.obs;

  int calculateFinalRating(){
    return ratingSum.value~/voteCounter.value;
  }

}