import 'package:flutter/material.dart';
import 'package:ott101/model/user_model.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, user.r, user.g, user.b),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          )
      ),
      child: Text(
        user.name.isNotEmpty ? user.name[0] : '',
        style: TextStyle(
          fontSize: 34,
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
