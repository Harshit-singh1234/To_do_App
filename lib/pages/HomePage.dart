import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_appp_project/Custom/TodoCard.dart';
import 'package:todo_appp_project/Service/Auth_Service.dart';
import 'package:todo_appp_project/pages/Addtodo.dart';
import 'package:todo_appp_project/pages/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("todo_list").snapshots();
  AuthClass authClass = AuthClass();
  List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Scedule",
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/IMG_8978.JPG"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Monday 21",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      var instance =
                          FirebaseFirestore.instance.collection("todo_list");
                      for (int i = 0; i < selected.length; i++) {
                        instance.doc().delete();
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
            label: " ",
          ),
          BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => const AddTodoPage()));
                },
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [
                        Colors.indigoAccent,
                        Colors.purple,
                      ])),
                  child: const Icon(
                    Icons.add,
                    size: 29,
                    color: Colors.white,
                  ),
                ),
              ),
              label: " "),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
                color: Colors.white,
              ),
              label: " "),
        ],
      ),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  IconData? iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                      snapshot.data?.docs[index].data() as Map<String, dynamic>;
                  switch (document["Category"]) {
                    case "Work":
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.red;
                      break;
                    case "WorkOut":
                      iconData = Icons.alarm;
                      iconColor = Colors.teal;
                      break;
                    case "Design":
                      iconData = Icons.music_note;
                      iconColor = Colors.green;
                      break;
                    case "Run":
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.black;
                      break;
                    case "Food":
                      iconData = Icons.local_grocery_store;
                      iconColor = Colors.blue;
                      break;
                    default:
                      iconData = Icons.run_circle_outlined;
                      iconColor = Colors.red;
                  }
                  selected.add(Select(
                      id: snapshot.data!.docs[index].id, checkValue: false));
                  //  itemBuilder: (context, Index) {Map<String, dynamic> document =snapshot.data?.docs[Index].data() as Map<String, dynamic>;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((builder) => ViewData(
                                    document: document,
                                    id: snapshot.data!.docs[index].id,
                                  ))));
                    },
                    child: TodoCard(
                      title: document["title"] ?? "Hey there",
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      iconColor: iconColor,
                      iconData: iconData,
                      onChange: onChange,
                      time: "12 AM",
                      index: index,
                    ),
                  );
                });
          }),

      // body: SingleChildScrollView(
      //   child: Container(
      //     // height: MediaQuery.of(context).size.height,
      //     // width: MediaQuery.of(context).size.width,
      //     padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         TodoCard(
      //           title: "wake up bro",
      //           check: true,
      //           iconBgColor: Colors.white,
      //           iconColor: Colors.red,
      //           iconData: Icons.alarm,
      //           time: "10 AM",
      //         ),
      //         SizedBox(height: 10),
      //         TodoCard(
      //           title: "Let's do Gym",
      //           check: false,
      //           iconBgColor: Colors.white,
      //           iconColor: Colors.red,
      //           iconData: Icons.run_circle,
      //           time: "11 AM",
      //         ),
      //         SizedBox(height: 10),
      //         TodoCard(
      //           title: "Buy some  Food",
      //           check: true,
      //           iconBgColor: Colors.white,
      //           iconColor: Colors.red,
      //           iconData: Icons.folder_off,
      //           time: "12 AM",
      //         ),
      //         SizedBox(height: 10),
      //         TodoCard(
      //           title: "Testing Something",
      //           check: true,
      //           iconBgColor: Colors.white,
      //           iconColor: Colors.red,
      //           iconData: Icons.explore,
      //           time: "1 pm",
      //         ),
      //         SizedBox(height: 10),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

/*
IconButton(icon: Icon(Icons.logout), onPressed: ()async =>{
      await authClass.logout(),
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) =>SignUpPage()), (route) => false),  
*/

class Select {
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}
