import 'dart:io';
// import 'package:addstudentpro/widget/edit_st.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Studentinformation extends StatelessWidget {
  final String name;
  final String age;
  final String number;
  final String place;
  final String photo;
  int? index;

  Studentinformation(
      {super.key,
      required this.name,
      required this.age,
      required this.number,
      required this.place,
      required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(' Informations')),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(10.5),
        color: Colors.green[100],
        child: Column(
          children: [
            const Center(
                child: Text(
              'Student All Information',
              style: TextStyle(color: Colors.black, fontSize: 25),
            )),
            const SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: FileImage(File(photo)),
            ),
            const SizedBox(
              height: 25,
            ),
            Text("Name:$name",
                style: const TextStyle(color: Colors.black, fontSize: 25)),
            const SizedBox(
              height: 25,
            ),
            Text("Age:$age",
                style: const TextStyle(color: Colors.black, fontSize: 25)),
            const SizedBox(
              height: 25,
            ),
            Text("Number:$number",
                style: const TextStyle(color: Colors.black, fontSize: 25)),
            const SizedBox(
              height: 25,
            ),
            Text("Place:$place",
                style: const TextStyle(color: Colors.black, fontSize: 25)),
            const SizedBox(
              height: 25,
            ),
            // ElevatedButton.icon(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => EditStudent(
            //                 name: name,
            //                 age: age,
            //                 place: place,
            //                 mobile: number,
            //                 index: 0,
            //                 photo: photo),
            //           ));
            //     },
            //     icon: Icon(Icons.edit),
            //     label: Text('Edit Details')),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text(
                  ' Back',
                ))
          ],
        ),
      )),
    );
  }
}
