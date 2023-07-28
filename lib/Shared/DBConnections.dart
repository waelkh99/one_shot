import 'package:mongo_dart/mongo_dart.dart';
class DBConnections{
    static Future<String> signup(String username, String password) async {
      var db = await Db.create("mongodb+srv://Djangus:mohmmadKH91@cluster0.aslouxx.mongodb.net/OneShotDB?retryWrites=true&w=majority");
      await db.open();
      var users = db.collection("Users");
      var checkUserExist = await users.find(where.eq('Username', username)).toList();
      if (checkUserExist.isNotEmpty){
        return "User Already Exists";
      }
      await users.insertOne({'Username': username, 'Password': password});
      return "";
    }
    static Future<String> signIn(String username, String password) async {
      var db = await Db.create("mongodb+srv://Djangus:mohmmadKH91@cluster0.aslouxx.mongodb.net/OneShotDB?retryWrites=true&w=majority");
      await db.open();
      var users = db.collection("Users");
      var checkUserExist = await users.find(where.eq('Username', username).eq('Password', password)).toList();
      if (checkUserExist.isNotEmpty){
        return "";
      }
      else{
       return "User Already Exists";
      }
    }
}