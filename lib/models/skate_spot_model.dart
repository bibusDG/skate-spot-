
class SpotModel {

  // int id;
  String spotName;
  String spotDescription;
  List? spotProperties;
  List? spotImages;
  Address? address;
  int? voteCounter;
  int? ratingSum;
  int? finalRating;


  SpotModel({
    // required this.id,
    required this.spotName,
    required this.spotDescription,
    this.spotProperties,
    this.spotImages,
    this.address,
    this.voteCounter,
    this.ratingSum,
    this.finalRating,

  });

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      // "id": id,
      "spotName": spotName,
      "spotDescription": spotDescription,
      'spotProperties': spotProperties,
      'spotImages': spotImages,
      'address': address,
      'voteCounter': voteCounter,
      'ratingSum': ratingSum,
      'finalRating': finalRating,


    };
  }
}

class Address{
  String countryName;
  String cityName;
  String postalCode;
  String streetName;
  String streetNumber;


  Address({required this.countryName, required this.cityName, required this.postalCode, required this.streetName, required this.streetNumber});

}