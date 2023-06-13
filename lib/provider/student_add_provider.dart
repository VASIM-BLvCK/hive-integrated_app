import 'dart:io';

import 'package:addstudentpro/DB/model/model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

final List<StudentModel> studentList = [];

class StudentAddProvider extends ChangeNotifier {
// add student
  File? photo;
  final namecontroll = TextEditingController();
  final agecontroll = TextEditingController();
  final phonecontroll = TextEditingController();
  final placecontroll = TextEditingController();

  final formkey = GlobalKey<FormState>();

  // Edit student
  TextEditingController editNamecontroller = TextEditingController();
  TextEditingController editAgecontroller = TextEditingController();
  TextEditingController editPlacecontroller = TextEditingController();
  TextEditingController editNumbercontroller = TextEditingController();
  TextEditingController editPhotoController = TextEditingController();
  final editformkey = GlobalKey<FormState>();
  File? fileImage;

  get path => null;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().getImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final phototemp = File(photo.path);
      fileImage = phototemp;
    }
    notifyListeners();
  }

  Future<void> addStudent(StudentModel value) async {
    final studentdb = await Hive.openBox<StudentModel>('StudentDb');
    await studentdb.add(value);
    studentList.add(value);
    getAllStudents();
    // studentList.clear();
    notifyListeners();
  }

  Future<void> getAllStudents() async {
    final studentdb = await Hive.openBox<StudentModel>('StudentDb');
    studentList.clear();
    studentList.addAll(studentdb.values);
    notifyListeners();
  }

  Future<void> deleteStudent(int index) async {
    final studentdb = await Hive.openBox<StudentModel>('StudentDb');
    await studentdb.deleteAt(index);
    getAllStudents();
    notifyListeners();
  }

  Future<void> editStudent(int index, StudentModel value) async {
    final studentdb = await Hive.openBox<StudentModel>('StudentDb');
    await studentdb.putAt(index, value);
    getAllStudents();
    notifyListeners();
  }
}
