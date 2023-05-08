import 'package:flutter/material.dart';



Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

TextField reusablesTextField(String text, IconData icon, bool isPasswordtype,
    TextEditingController controller) {
  return TextField(
    
    controller: controller,
    obscureText: true,
    enableSuggestions: !isPasswordtype,
    autocorrect: !isPasswordtype,
    cursorColor: Colors.amber,
    style: TextStyle(color: Colors.black.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.black.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordtype
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container FirebaseButton(BuildContext context, String title, Function ontap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        ontap();
      },
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.amber[400];
            }
            return Colors.black;
          }),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}


class OnboardModel {
  String img;
  String text;
  String desc;
  Color bg;
  Color button;

  OnboardModel({
    required this.img,
    required this.text,
    required this.desc,
    required this.bg,
    required this.button,
  });
}
