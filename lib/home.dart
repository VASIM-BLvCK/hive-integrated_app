import 'package:addstudentpro/provider/student_add_provider.dart';
import 'package:addstudentpro/widget/addst.dart';
import 'package:addstudentpro/widget/listst.dart';
import 'package:addstudentpro/widget/search.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<StudentAddProvider>(context, listen: false).getAllStudents();
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Center(
          child: Text('Add Students'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchWidget());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const SafeArea(
          child: Column(
        children: [Expanded(child: ListStudentWidget())],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const AddStudentWidget();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
