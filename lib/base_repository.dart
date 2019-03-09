import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wgmanager/datamodels/datamodel.dart';

typedef DataModelType Serializer<DataModelType extends DataModel>(
    Map<String, dynamic> map, String id);

abstract class BaseRepository<DataModelType extends DataModel> {
  Firestore _firestore = Firestore(app: FirebaseApp.instance);
  String collectionName;
  CollectionReference collectionReference;

  BaseRepository(this.collectionName, {this.collectionReference}) {
    if (collectionReference == null)
      collectionReference = _firestore.collection(collectionName);
  }

  Future<DataModelType> add(DataModelType model,
      {String uid, DocumentReference documentReference}) async {
    var map = model.toMap();
    map["created"] = FieldValue.serverTimestamp();
    if (documentReference == null) if (uid == null) {
      documentReference = await collectionReference.add(map);
    } else {
      documentReference = collectionReference.document(uid);
      await documentReference.setData(map);
    }
    else {
      await documentReference.setData(map);
    }
    var snap = await documentReference.get();
    return fromJson(snap);
  }

  Future<DocumentReference> getDocumentReference() async {
    return collectionReference.document();
  }

  Future<bool> exists(String id) async {
    var snapshot = await collectionReference.document(id).get();
    return snapshot.exists;
  }

  Future<DataModelType> get(String id) async {
    var snapshot = await collectionReference.document(id).get();
    return fromJson(snapshot);
  }

  Stream<DataModelType> snapshot(String id) {
    var snapshot = collectionReference.document(id).snapshots();
    return filterAndSerializeSnapshot(snapshot);
  }

  Stream<DataModelType> getSnapshot(String id) {
    var snapshots = collectionReference.document(id).snapshots();
    return snapshots.map((snapshot) => fromJson(snapshot));
  }

  CollectionReference query() {
    return collectionReference;
  }

  CollectionReference getSubCollectionReference(
      String id, String collectionName) {
    return collectionReference.document(id).collection(collectionName);
  }

  Future update(DataModelType model) async {
    var map = model.toMap();
    map["updated"] = FieldValue.serverTimestamp();
    await collectionReference.document(model.id).updateData(map);
  }

  Future delete(String id) async {
    await collectionReference.document(id).delete();
  }

  DataModelType fromJson(DocumentSnapshot snap) {
    DataModelType model;
    if (!snap.exists) return null;
    model = Serialization.fromMap(snap.data);
    model.id = snap.documentID;
    return model;
  }

  Stream<List<DataModelType>> snapshots(Query query) {
    return query
        .snapshots()
        .map((snap) => snap.documents.map((doc) => fromJson(doc)).toList())
        .where((snap) => !snap.any((item) => item.created == null));
  }

  Stream<DataModel> filterAndSerializeSnapshot(
      Stream<DocumentSnapshot> snapshot) {
    return snapshot
        .map((snap) => fromJson(snap))
        .where((snap) => snap.created != null);
  }

  Future<List<DataModelType>> documents(Query query) async {
    return (await query.getDocuments())
        .documents
        .map((doc) => fromJson(doc))
        .toList();
  }
}

class NeedsVersionUpdateException implements Exception {}
