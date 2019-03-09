import 'package:cloud_firestore/cloud_firestore.dart';

abstract class DataModel {
  Timestamp created;
  Timestamp updated;
  String id;

  String get type;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["type"] = type;
    return map;
  }

  fromMap(Map<String, dynamic> map) {}
}

class User extends DataModel {
  @override
  String get type => "User";
}

class Serialization {
  static DataModel fromMap(Map<String, dynamic> map) {
    switch (map["type"]) {
      case "User":
        return User().fromMap(map);
        break;
      default:
        throw Exception("Missing type in Map");
    }
  }
}
