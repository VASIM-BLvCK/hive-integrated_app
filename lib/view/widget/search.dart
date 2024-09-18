import 'dart:io';
import 'package:addstudentpro/controller/student_add_provider.dart';
import 'package:addstudentpro/view/widget/informationst.dart';
import 'package:addstudentpro/view/widget/listst.dart';
import 'package:flutter/material.dart';

class SearchWidget extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final data = studentList[index];
        if (data.name.trim().contains(query.trim())||data.place.trim().contains(query.trim())) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return const ListStudentWidget();
                      }),
                    ),
                  );
                },
                title: Text(data.name),
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(data.photo)),
                ),
              ),
              const Divider()
            ],
          );
        } else {
          return Container();
        }
      },
      itemCount: studentList.length,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final data = studentList[index];

        if (data.name.toLowerCase().contains(query.toLowerCase().trim())||data.place.toLowerCase().contains(query.toLowerCase().trim())) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return Studentinformation(
                            name: data.name,
                            age: data.age,
                            number: data.mobile,
                            place: data.place,
                            photo: data.photo);
                      }),
                    ),
                  );
                },
                title: Text(data.name),
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(data.photo)),
                ),
              ),
              const Divider()
            ],
          );
        } else {
          return Container();
        }
      },
      itemCount: studentList.length,
    );
  }
}
