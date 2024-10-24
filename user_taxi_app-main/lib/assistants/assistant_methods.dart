import 'package:firebase_database/firebase_database.dart';
import 'package:user_taxi_app/global/global.dart';
import 'package:user_taxi_app/models/user_model.dart';

class AssistantMethods{
  static void readCurrentOnLineUserInfo()async {
    
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
    .ref()
    .child("users")
    .child(currentFirebaseUser!.uid);
    userRef.once().then((snap)
        {
          if(snap.snapshot.value != null){
           userModelCurrentInfo =  UserModel.fromSnapshot(snap.snapshot);
           print("name :" + userModelCurrentInfo!.name.toString());
           print("email : " +userModelCurrentInfo!.email.toString());

          }
        });
   }
}