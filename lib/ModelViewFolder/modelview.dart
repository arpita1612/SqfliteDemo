import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_login/model/ModelMap.dart';
import 'package:sqflite_login/model/dbModel.dart';
import 'package:mvvm/mvvm.dart';

//class DataBaseModelView extends ViewModel {
final dbInstance = DataBaseClass.instance;

void insertData() async {
  Map<String, dynamic> row = {
    DataBaseClass.name: registerData['Name'],
    DataBaseClass.contact: registerData['Contact'],
    DataBaseClass.email: registerData['Email'],
    DataBaseClass.password: registerData['Password']
  };
  final id = await dbInstance.insert(row);

  _setSP(registerData);
  print(id);
}

void queryAll() async {
  var resultData = await dbInstance.queryall();
  resultData.forEach((row) {
    print(row);
  });
}

Future<bool> queryByCondition() async {
  List<Map<String, dynamic>> resultData =
      await dbInstance.queryspecific(authData['Email'], authData['Password']);

  print(resultData);
  return resultData.isEmpty ? true : false;
}

void delete() async {
  var id = await dbInstance.deletedata(1);
  print(id);
}

void update() async {
  var row = await dbInstance.update(2);
  print(row);
}

void _setSP(Map data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('UserName', data['Name']);
  prefs.setString('Email', data['Email']);
}
// }
