import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'contact_model.dart';
import 'log_in.dart';

class Homescreen extends StatefulWidget {
  final ContactModel? initialUser;

  const Homescreen({super.key, this.initialUser});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialUser != null) {
      users.add({
        'name': widget.initialUser!.name,
        'email': widget.initialUser!.email,
        'phone': widget.initialUser!.phone,
        'image': widget.initialUser!.image,
      });
    }
  }

  void deleteAllUsers() {
    setState(() {
      users.clear();
    });
  }


  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }


  void addUser(Map<String, dynamic> newUser) {
    setState(() {
      users.add(newUser);
    });
  }
  void _showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Login(
              onUserAdded: (ContactModel newUser) {
                setState(() {
                  users.add({
                    'name': newUser.name,
                    'email': newUser.email,
                    'phone': newUser.phone,
                    'image': newUser.image,
                  });
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: deleteAllUsers,
              backgroundColor: const Color(0xffF93E3E),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: ()  {
                _showLoginBottomSheet(context);

              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        backgroundColor: const Color(0xff29384D),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/pic1.png",
                width: 117,
                height: 39,
              ),
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.60,
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffFFF1D4)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        user['image'] != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            user['image'],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                            : Lottie.asset("assets/animations/empty_list.json"),
                              Container(
                                margin: const EdgeInsets.only(top: 130, left: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  user['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff29384D),
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(16),
                                      bottomLeft: Radius.circular(16))
                                ),
                                margin: const EdgeInsets.only(top: 180),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.email_rounded),
                                        Text(
                                          "  ${user['email']}",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff29384D),
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.phone_in_talk_sharp),
                                        Text(
                                          "  ${user['phone']}",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xff29384D),
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                alignment: Alignment.center,
                                margin:  EdgeInsets.only(
                                    top: 250, left: 10, bottom: 0, right: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    deleteUser(index);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffF93E3E),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.delete, color: Colors.white,
                                      size: 25,),
                                      SizedBox(width: 2),
                                      Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
