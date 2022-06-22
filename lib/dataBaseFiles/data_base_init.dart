import 'package:skate_spots/models/skate_spot_model.dart';//import model class
import 'package:sqflite/sqflite.dart'; //sqflite package
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //used to join paths
import 'dart:io';
import 'dart:async';

class InitDataBase {

  static const _dbName = 'spotDataBase.db';
  static const _dbVersion = 1;


  static const _tableName = 'spotTable';
  static const spotID ='_id';
  static const spotName ='Spot_name';
  static const spotDescription ='Spot_description';
  static const spotProperties ='Spot_properties';
  static const countryName ='Country_name';
  static const cityName = 'City_name';
  static const postalCode = 'Postal_code';
  static const streetName = 'Street_name';
  static const streetNumber = 'Street_number';
  static const voteCounter = 'Vote_counter';
  static const ratingSum = 'Rating_sum';
  static const finalRating = 'Final_Rating';
  static const spotImages = 'Spot_images';
  static const ridersCounter = 'Riders_counter';



  InitDataBase._privateConstructor();
  static final InitDataBase instance = InitDataBase._privateConstructor();

  static Database? _database;
  Future<Database> get database async=>
      _database ??= await _initiateDatabase();


  _initiateDatabase () async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future? _onCreate(Database db, int version){
    db.execute(
    '''
    CREATE TABLE $_tableName(
    $spotID INTEGER PRIMARY KEY AUTOINCREMENT,
    $spotName TEXT,
    $spotDescription TEXT,
    $spotProperties TEXT,
    $countryName TEXT,
    $cityName TEXT,
    $postalCode TEXT,
    $streetName TEXT,
    $streetNumber TEXT,
    $voteCounter INTEGER,
    $ratingSum INTEGER,
    $finalRating INTEGER, 
    $spotImages TEXT,
    $ridersCounter INTEGER)
    '''
    );
  }

  Future<int> insert(Map<String, dynamic> row) async{
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async{
    Database db = await instance.database;
    int id = row[spotID];
    return await db.update(_tableName, row, where: '$spotID = ?', whereArgs: [id]);
  }

}
