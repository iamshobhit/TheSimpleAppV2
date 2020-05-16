import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesimpleappv2/models/ninjamodel.dart';
import 'package:thesimpleappv2/models/user.dart';

class DatabaseService {
final String uid;
DatabaseService({this.uid});
// collection Reference
final CollectionReference myCollection= Firestore.instance.collection('Sports');
Future updateUserData(String sugar,String name,int strength) async{
  return await myCollection.document(uid).setData({
    "sugar":sugar,
    "name":name,
    "strength":strength,

  });
}

//ninja list from snapshot
  List<Ninja> _showListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc) {
    return Ninja(
      name: doc.data['name']?? '',
      strength: doc.data['strength']?? 0,
      sugar: doc.data['sugar']?? '0',
    );
  }).toList();
  }
// user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  return UserData(
    uid: uid,
    name: snapshot.data['name'],
    sugar: snapshot.data['sugar'],
    strength: snapshot.data['strength'],
  );
  }

// get Stream
  Stream<List<Ninja>> get ninjas{
    return myCollection.snapshots()
        .map(_showListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
  return myCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}
