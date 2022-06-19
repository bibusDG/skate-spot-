import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:skate_spots/views/newSpotPage/controllers/new_spot_controller.dart';


import '../../geolocation.dart';

class NewSpotPage extends StatelessWidget {
  const NewSpotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    NewSpotController newSpotController = Get.put(NewSpotController());

    /// LIST OF SPOT PROPERTIES

    List spotData = ['rails', 'stairs', 'gaps', 'flat', 'concrete', 'grinds', 'banks', 'wood', 'asphalt',
                    'street', 'skatepark'];

    GeoLocation geoLocation = GeoLocation();

    Map manualLocalization = {'country': '', 'city': '', 'postalCode': '', 'streetName': '', 'streetNumber': ''};

    return SafeArea(
      child: Scaffold(
        body:Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                      onChanged: (String value){
                        newSpotController.spotName.value = value;
                      },
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Enter spot name',
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    onChanged: (String value){
                      newSpotController.spotDescription.value = value;
                    },
                      minLines: 3,
                      maxLines: 4,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Describe spot',
                          hintStyle: TextStyle(
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )
                      ),
                    ),

                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MultiSelectDialogField(
                    title: Text(''),
                    buttonText: Text('Choose spot details'),
                    items: spotData.map((e) => MultiSelectItem(e, e)).toList(),
                    listType: MultiSelectListType.CHIP,
                    onConfirm: (values) {
                      newSpotController.spotProperties.value = values;
                    },
                  ),
                ),
                SizedBox(height: 30.0,),
                ElevatedButton(onPressed: (){
                  Get.defaultDialog(
                    title:'Take a shot',
                    content: Column(
                      children: [
                        ElevatedButton(onPressed: (){
                          Get.back();
                          Get.defaultDialog(

                            title: 'Fill the data',
                            content: Expanded(flex:1,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(

                                        onChanged: (String value){
                                          manualLocalization['country'] = value;
                                          // newSpotController.countryName.value = value;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: 'Country',
                                            hintStyle: TextStyle(
                                                color: Colors.grey
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (String value){
                                          manualLocalization['city'] = value;
                                          // newSpotController.cityName.value = value;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: 'City',
                                            hintStyle: TextStyle(
                                                color: Colors.grey
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (String value){
                                          manualLocalization['postalCode'] = value;
                                          // newSpotController.postalCode.value = value;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: 'Postal Code',
                                            hintStyle: TextStyle(
                                                color: Colors.grey
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (String value){
                                          manualLocalization['streetName'] = value;
                                          // newSpotController.streetName.value = value;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: 'Street name',
                                            hintStyle: TextStyle(
                                                color: Colors.grey
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (String value){
                                          manualLocalization['streetNumber'] = value;
                                          // newSpotController.streetNumber.value = value;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: 'Street number',
                                            hintStyle: TextStyle(
                                                color: Colors.grey
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                            )
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(onPressed: (){
                                      newSpotController.countryName.value = manualLocalization['country'];
                                      newSpotController.cityName.value = manualLocalization['city'];
                                      newSpotController.postalCode.value = manualLocalization['postalCode'];
                                      newSpotController.streetName.value = manualLocalization['streetName'];
                                      newSpotController.streetNumber.value = manualLocalization['streetNumber'];
                                      Get.back();
                                      Get.snackbar('Spot location', 'Data Saved');
                                    }, child: Text('Save data')),

                                  ],
                                ),
                              ),
                            ),
                          );

                        }, child: Text('Insert address manually')),
                        ElevatedButton(onPressed: ()async{
                          Get.back();
                          geoLocation.determinePosition;
                          geoLocation.finalPosition();
                          // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                          // print(position);

                        }, child: Text('Insert from GPS')),
                      ],
                    ),


                  );

                }, child: Text('Insert spot location')),
                ElevatedButton(onPressed: (){
                }, child: Text('Take a photo')),
                SizedBox(height: 100.0,),
                ElevatedButton(onPressed: (){

                  if(newSpotController.spotName.value != ''){
                    newSpotController.addSpot();
                    Get.snackbar('New spot', 'New spot successfully added');

                    newSpotController.countryName.value = '';
                    newSpotController.cityName.value = '';
                    newSpotController.postalCode.value = '';
                    newSpotController.streetName.value = '';
                    newSpotController.streetNumber.value = '';
                    newSpotController.spotProperties.value = [];
                    newSpotController.spotName.value = '';
                    newSpotController.spotDescription.value = '';
                    manualLocalization = {'country': '', 'city': '', 'postalCode': '', 'streetName': '', 'streetNumber': ''};

                  }else{
                    Get.defaultDialog(
                        title: 'Warning!!!',
                        content: Text('Name of spot obligatory')
                    );
                  }
                }, child: Text('Add new spot')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
