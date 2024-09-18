import 'dart:io';
import 'package:addstudentpro/controller/student_add_provider.dart';
import 'package:addstudentpro/view/widget/edit_st.dart';
import 'package:addstudentpro/view/widget/informationst.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentAddProvider>(
      builder: (BuildContext ctx, studetListModel, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final data = studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: FileImage(
                    File(data.photo),
                  ),
                ),
                title: Text(data.name),
                trailing: Wrap(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EditStudent(
                              name: data.name,
                              age: data.age,
                              place: data.place,
                              mobile: data.mobile,
                              index: index,
                              photo: data.photo,
                            );
                          },
                        ));
                      },
                      icon: const Icon(Icons.edit_calendar)),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: const Text('Delete'),
                                content: const Text('Delete This Student ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel')),
                                  TextButton(
                                      onPressed: () {
                                        Provider.of<StudentAddProvider>(context,
                                                listen: false)
                                            .deleteStudent(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ))
                                ],
                              );
                            }));
                      },
                      icon: const Icon(Icons.delete))
                ]),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Studentinformation(
                          name: data.name,
                          age: data.age,
                          number: data.mobile,
                          place: data.place,
                          photo: data.photo);
                    },
                  ));
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.black,
              );
            },
            itemCount: studentList.length);
      },
    );
  }
}
