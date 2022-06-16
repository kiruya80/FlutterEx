import 'package:firebase_database/firebase_database.dart';
import 'package:flutterex/controllers/base_controller.dart';

class FireDatabaseController extends BaseController {
  FirebaseDatabase database = FirebaseDatabase.instance;

  // void createdata(String code, String name, String status) {
  //   final usercol =
  //       FirebaseFirestore.instance.collection("players").doc("$code");
  //   usercol.set({
  //     "name": "$name",
  //     "status": "$status",
  //   });
  // }
  //
  // void readdata(String code) {
  //   final usercol =
  //       FirebaseFirestore.instance.collection("players").doc("$code");
  //   usercol.get().then((value) => {print(value.data())});
  // }
  //
  // void updatedata(String code, String status) {
  //   final usercol =
  //       FirebaseFirestore.instance.collection("players").doc("$code");
  //   usercol.update({
  //     "status": "$status",
  //   });
  // }
  // void deletedata(String code){
  //   final usercol=FirebaseFirestore.instance.collection("players").doc("$code");
  //   usercol.delete();
  // }

}
