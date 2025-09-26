import 'dart:io';

class ContactModel{
  String name;
  String phone;
  String email;
  File? image;

  ContactModel({required this.name, required this.phone, required this.email, this.image});
}