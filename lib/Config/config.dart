import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';


class EcomApp{
  static const String appName = 'ecom-flutter';

  static SharedPreferences sharedPreferences;
  static auth.User user;


}