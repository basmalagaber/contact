import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'contact_model.dart';
import 'homescreen.dart';
import 'log_in.dart';

class AddNewUser extends StatefulWidget {

   AddNewUser({super.key});

  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  List<Map<String, dynamic>> users = [];
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
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homescreen(
                      initialUser: newUser,
                    ),
                  ),
                );

              },
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29384D),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showLoginBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/pic1.png",
                      width: 117,
                      height: 39,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Lottie.asset("assets/animations/image_picker.json",
                  height: 460,
                  width: 360),
                  const Text(
                    "There is No Contacts Added Here",
                    style: TextStyle(color: Color(0xffFFF1D4), fontSize: 20),
                  ),
          
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}

