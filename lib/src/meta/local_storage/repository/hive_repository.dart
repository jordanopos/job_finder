import 'package:hive/hive.dart';

abstract class HiveRepository {
  Future<void> saveData(String box, String key, dynamic value);
  Future<dynamic>? getData(String key, String boxName);
  Future<void>? deleteData(String box, String key);
}

class HiveImpl extends HiveRepository {
  @override
  Future<void> saveData(String boxName, String key, value) async {
    var box = await Hive.openBox(boxName);

    await box.put(key, value);
  }

  @override
  Future<dynamic>? getData(String key, String boxName) async {
    var box = await Hive.openBox(boxName);

    var value = box.get(key);

    print(value);
    return value;
  }

  @override
  Future<void>? deleteData(String boxName, String key) async {
    var box = await Hive.openBox(boxName);

    await box.delete(key);
  }
}
