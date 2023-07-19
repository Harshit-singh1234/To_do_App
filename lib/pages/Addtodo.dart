
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descontroller = TextEditingController();
  String type = "";
  String category = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff1d1e26), Color(0xff252041)],
        )),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.arrow_left,
                color: Colors.white,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "New Todo",
                      style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    label("Task Title"),
                    const SizedBox(
                      height: 12,
                    ),
                    title(),
                    const SizedBox(
                      height: 30,
                    ),
                    label("Task Type"),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        task("Important", 0xff2664fa),
                        const SizedBox(
                          width: 20,
                        ),
                        task("planned", 0xff2bc8d9)
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    label("Decription"),
                    const SizedBox(
                      height: 12,
                    ),
                    description(),
                    const SizedBox(
                      height: 25,
                    ),
                    label("Category"),
                    const SizedBox(
                      height: 12,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        categoryselect("Food", 0xffff6d6e),
                        const SizedBox(
                          width: 20,
                        ),
                        categoryselect("WorkOut", 0xfff29732),
                        const SizedBox(
                          width: 20,
                        ),
                        categoryselect("Work", 0xff6557ff),
                        const SizedBox(
                          width: 20,
                        ),
                        categoryselect("Design", 0xff234ebd),
                        const SizedBox(
                          width: 20,
                        ),
                        categoryselect("Run", 0xff2bc8d9),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    button(),
                    const SizedBox(
                      height: 30,
                    ),
                  ]),
            )
          ],
        )),
      ),
    );
  }

  Widget button() {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("todo_list").add({
          "title": _titlecontroller.text,
          "task": type,
          "Category": category,
          "description": _descontroller.text
        });
        Navigator.pop(context); 
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ])),
        child: const Center(
            child: Text(
          "Add ToDo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: _descontroller,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget task(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: type == label ? Colors.white : Color(color),
        label: Text(label),
        labelStyle: TextStyle(
          color: type == label ? Colors.black : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget categoryselect(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: category == label ? Colors.white : Color(color),
        label: Text(label),
        labelStyle: TextStyle(
          color: category == label ? Colors.black : Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titlecontroller,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 17,
        ),
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Task Title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2),
    );
  }
}
