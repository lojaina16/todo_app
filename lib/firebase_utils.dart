import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTaskCollection(); //create collection
    var docRef = taskCollection.doc(); //create document
    task.id = docRef.id; //auto id
    return docRef.set(task); // take task and put it in firebase
  }

  static Stream<QuerySnapshot<Task>> getTasks(DateTime date) {
    return getTaskCollection()
        .where("dateTime",
            isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .snapshots();
  }

  static Future<void> deleteTask(String id) {
    return getTaskCollection().doc(id).delete();
  }

  static Future<void> isDoneTask(Task task) {
    return getTaskCollection().doc(task.id).update({"isDone": !task.isDone!});
  }

  static Future<void> updateTask(Task task) {
    return getTaskCollection().doc(task.id).update(task.toFireStore());
  }
}
