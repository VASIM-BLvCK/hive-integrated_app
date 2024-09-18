import 'dart:io';
import 'package:addstudentpro/controller/student_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../DB/model/model.dart';

class EditStudent extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String mobile;
  final String photo;
  final int index;

  const EditStudent({
    super.key,
    required this.name,
    required this.age,
    required this.place,
    required this.mobile,
    required this.index,
    required this.photo,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<StudentAddProvider>(
              builder: (context, editStudentModel, child) {
            editStudentModel.editNamecontroller =
                TextEditingController(text: name);
            editStudentModel.editAgecontroller =
                TextEditingController(text: age);
            editStudentModel.editPlacecontroller =
                TextEditingController(text: place);
            editStudentModel.editNumbercontroller =
                TextEditingController(text: mobile);
            editStudentModel.editPhotoController =
                TextEditingController(text: photo);

            return Form(
                key: editStudentModel.editformkey,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const Text(
                        'Edit student details',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: editStudentModel.fileImage == null
                            ? FileImage(
                                File(photo),
                              )
                            : FileImage(File(editStudentModel.fileImage!.path)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: editStudentModel.editNamecontroller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '',
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLength: 2,
                        controller: editStudentModel.editAgecontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your age',
                          labelText: 'Age',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Age';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLength: 10,
                        controller: editStudentModel.editNumbercontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your phn',
                          labelText: 'Number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Number';
                          } else if (value.length < 10) {
                            return 'invalid phone number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: editStudentModel.editPlacecontroller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your Place',
                          labelText: 'Place',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required Address';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              if (editStudentModel.editformkey.currentState!
                                  .validate()) {
                                onEditSaveButton(
                                  context,
                                  index: index,
                                  age: editStudentModel.editAgecontroller,
                                  name: editStudentModel.editNamecontroller,
                                  place: editStudentModel.editPlacecontroller,
                                  number: editStudentModel.editNumbercontroller,
                                  photo:
                                      editStudentModel.fileImage?.path ?? photo,
                                );
                                Navigator.of(context).pop();
                              }
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          }),
        ),
      ),
    );
  }

  Future<void> onEditSaveButton(
    ctx, {
    required index,
    required TextEditingController name,
    required TextEditingController age,
    required TextEditingController place,
    required TextEditingController number,
    required photo,
  }) async {
    final studentmodel = StudentModel(
      name: name.text,
      age: age.text,
      mobile: number.text,
      place: place.text,
      photo: photo,
    );
    ScaffoldMessenger.of(ctx).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        backgroundColor: Colors.green,
        content: Text(
          'Saved',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
    Provider.of<StudentAddProvider>(ctx, listen: false)
        .editStudent(index, studentmodel);
  }
}
