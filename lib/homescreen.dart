import 'package:flutter/material.dart';
import 'adduser.dart';

class Homescreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPhone;

  const Homescreen({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, String>> users = [];

  @override
  void initState() {
    super.initState();
    users.add({
      'name': widget.userName,
      'email': widget.userEmail,
      'phone': widget.userPhone,
    });
  }

  void deleteLastUser() {
    setState(() {
      if (users.isNotEmpty) {
        users.removeLast();
      }
    });
  }

  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  void addUser(Map<String, String> newUser) {
    setState(() {
      users.add(newUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: deleteLastUser,
              backgroundColor: Color(0xffF93E3E),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNewUser()),
                );
                if (result != null) {
                  addUser(result);
                }
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        backgroundColor: const Color(0xff29384D),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 250,
                  width: 220,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffFFF1D4)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/pic3.gif",
                        width: double.infinity,
                        height: 100,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 80, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          users[index]['name'] ?? '',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 130),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.messenger_outlined,
                                  color: Color(0xff29384D),
                                ),
                                Text(
                                  "  ${users[index]['email'] ?? ''}",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: Color(0xff29384D),
                                ),
                                Text(
                                  "  ${users[index]['phone'] ?? ''}",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 200, left: 10, bottom: 10, right: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            deleteUser(index);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF93E3E),
                          ),
                          child: Row(
                            children: const [
                              SizedBox(width: 20),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              Text(
                                "Delete",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}