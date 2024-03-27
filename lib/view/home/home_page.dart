import 'dart:async';
import 'package:bloc_sample/model/model_list.dart';
import 'package:bloc_sample/widget/login_page_fi.dart';
import 'package:bloc_sample/widget/text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String? selectedValue;
List<String> dropMenuItem = [
  'Femail',
  'Male',
  'Others',
];

const String keyValue = 'username';
String savedValue = 'seved_value';
  late SharedPreferences sp;


   
  
  
  
   
  


class _HomePageState extends State<HomePage> {
  late ConfettiController _confettiController;
  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  List<DataModel> contacts = List.empty(growable: true);
  final String nodataimg =
      'https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-8867280-7265556.png?f=webp';

  int selectedIndex = -1;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;
 
 

   

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: const Duration(milliseconds: 250),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Scaffold(
        // drawer: const DrawerWidget(),
        appBar: AppBar(
            leading: isDrawerOpen
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        xOffset = 0;
                        yOffset = 0;
                        scaleFactor = 1;
                        isDrawerOpen = false;
                      });
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        xOffset = 230;
                        yOffset = 150;
                        scaleFactor = 0.6;
                        isDrawerOpen = true;
                      });
                    },
                    icon: const Icon(Icons.menu, color: Colors.white)),
            backgroundColor: Colors.teal,
            toolbarHeight: 80,
            centerTitle: true,
            title: const Text(
              'Data List',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    final sharedPrefs = await SharedPreferences.getInstance();
                    sharedPrefs.remove(keyValue);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  )),
            ]),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: 'Name...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ))),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: typeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Age...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: DropdownButton(
                            value: selectedValue,
                            hint: Text(selectedValue == ''
                                ? "Select Gender"
                                : selectedValue.toString()),
                            items: dropMenuItem.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedValue = val;
                              });
                            }),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 180,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      selectedIndex == -1
                                          ? Colors.teal
                                          : Colors.green),
                                ),
                                onPressed: () {
                                  // saveData();
                                  String name = nameController.text.trim();
                                  String type = typeController.text.trim();

                                  if (name.isNotEmpty &&
                                      type.isNotEmpty &&
                                      selectedValue!.isNotEmpty) {
                                    setState(() {
                                      if (selectedIndex == -1) {
                                        // Add mode
                                        contacts.add(DataModel(
                                            name: name,
                                            age: type,
                                            gender: selectedValue!));
                                        successMessage(context);
                                      } else {
                                        // Edit mode
                                        contacts[selectedIndex].name = name;
                                        contacts[selectedIndex].age = type;
                                        contacts[selectedIndex].gender =
                                            selectedValue!;
                                        upDateMessage(context);
                                        selectedIndex = -1;
                                      }

                                      nameController.text = '';
                                      typeController.text = '';
                                      priorityController.text = '';
                                    
                                    });
                                  } else {
                                    errorMessage();
                                  }
                                },
                                child: Text(
                                  selectedIndex == -1 ? 'Save' : 'Update',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: ConfettiWidget(
                            confettiController: _confettiController,
                            blastDirectionality: BlastDirectionality.explosive,
                            shouldLoop: false,
                            colors: const [
                              Colors.green,
                              Colors.blue,
                              Colors.pink,
                              Colors.orange,
                              Colors.purple
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                  ],
                ),
                contacts.isEmpty
                    ? Column(
                        children: [
                          SizedBox(
                              height: 250,
                              width: 250,
                              child: Lottie.asset(
                                  'assets/splash/nodataanimation.json')),
                        ],
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) => getRow(index),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              final deletedContact = contacts[index];
              final deletedIndex = index;
              setState(() {
                contacts.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Data deleted'),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        contacts.insert(deletedIndex, deletedContact);
                      });
                    },
                  ),
                ),
              );
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              nameController.text = contacts[index].name;
              typeController.text = contacts[index].age;
              priorityController.text = contacts[index].gender;
              setState(() {
                selectedIndex = index;
              });
            },
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
            foregroundColor: Colors.white,
            child: Text(
              contacts[index].name[0],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name:  "),
                  Text("Age: "),
                  Text("Gender: "),
                ],
              ),
              const Gap(140),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: contacts[index].name,
                  ),
                  TextWidget(text: contacts[index].age),
                  TextWidget(
                    text: selectedValue!,
                  )

                  // TextWidget(text: contacts[index].gender),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void successMessage(BuildContext context) async {
    _confettiController.play();
    double snackBarOpacity = 0;

    final snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              snackBarOpacity = 1;
            });
          });

          return AnimatedOpacity(
            opacity: snackBarOpacity,
            duration: const Duration(seconds: 1),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 80,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 81, 146, 83),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Success",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "Data added successfully",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent, // Use a transparent background
      elevation: 0,
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void upDateMessage(BuildContext context) {
    double snackBarOpacity = 0;

    final snackBar = SnackBar(
      duration: const Duration(seconds: 4),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              snackBarOpacity = 1;
            });
          });

          return AnimatedOpacity(
            opacity: snackBarOpacity,
            duration: const Duration(seconds: 1),
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF046D8D),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(children: [
                Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Updated",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        "Data Updated successfully",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        },
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );

    // Show the snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  errorMessage() {
    Timer(const Duration(seconds: 1), () {});

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: AnimatedContainer(
        duration: const Duration(seconds: 5),
        curve: Curves.easeInQuart,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 80,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(178, 4, 42, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(children: [
            Icon(
              Icons.error,
              color: Colors.white,
            ),
            Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Error",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    "Data failed to add",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
Future<void> saveData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(savedValue, nameController.text);
  await prefs.setString(savedValue, typeController.text);
  await prefs.setString(savedValue, selectedValue ?? '');
}

}
