import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app.dart';
import 'package:todo_list/core/services/services_locator.dart';
import 'package:todo_list/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  ServicesLocator().init();
  runApp(const TodoApp());

}

