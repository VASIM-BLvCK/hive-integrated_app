import 'package:addstudentpro/controller/student_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../DB/model/model.dart';

class AddStudentWidget extends StatelessWidget {
  const AddStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentAddProvider>(
      builder: (context, addStudentModel, child) => Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: addStudentModel.formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  addStudentModel.fileImage == null
                      ? const CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              AssetImage('assets/image/profil.png'),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(
                              addStudentModel.fileImage!.path,
                            ),
                          ),
                          radius: 60,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () {
                            addStudentModel.getPhoto();
                          },
                          icon: const Icon(Icons.image_outlined),
                          label: const Text('Add image'))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addStudentModel.namecontroll,
                    maxLength: 20,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addStudentModel.agecontroll,
                    maxLength: 2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Requerd Age";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addStudentModel.phonecontroll,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Mobile'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Requerd number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addStudentModel.placecontroll,
                    maxLength: 15,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Place'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Requerd place";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (addStudentModel.formkey.currentState!.validate()) {
                          onbuttonclick(
                              context,
                              addStudentModel.namecontroll,
                              addStudentModel.agecontroll,
                              addStudentModel.phonecontroll,
                              addStudentModel.placecontroll);
                          Navigator.of(context).pop();
                          addStudentModel.namecontroll.clear();
                          addStudentModel.agecontroll.clear();
                          addStudentModel.phonecontroll.clear();
                          addStudentModel.placecontroll.clear();
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Students')),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Back'))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}

Future<void> onbuttonclick(
  context,
  TextEditingController namecontroll,
  TextEditingController agecontroll,
  TextEditingController phonecontroll,
  TextEditingController placecontroll,
) async {
  final name = namecontroll.text.trim();
  final age = agecontroll.text.trim();
  final mobile = phonecontroll.text.trim();
  final place = placecontroll.text.trim();

  if (name.isEmpty ||
      age.isEmpty ||
      mobile.isEmpty ||
      place.isEmpty ||
      Provider.of<StudentAddProvider>(context, listen: false)
          .fileImage!
          .path
          .isEmpty) {
    return;
  } else {
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'Student added',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
        )));
  }

  final students = StudentModel(
    name: name,
    age: age,
    mobile: mobile,
    place: place,
    photo:
        Provider.of<StudentAddProvider>(context, listen: false).fileImage!.path,
  );
  Provider.of<StudentAddProvider>(context, listen: false).addStudent(students);
}
