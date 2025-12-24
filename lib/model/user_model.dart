import 'dart:math';
import 'dart:ui';

class UserModel {
  final int id;
  String name;
  final int r;
  final int g;
  final int b;

  UserModel({
    required this.id,
    required this.name,
    required this.r,
    required this.g,
    required this.b,
  });

  Color get color {
    return Color.fromARGB(255, r, g, b);
  }

  String get firstCharOfName {
    return name.isNotEmpty ? name[0] : '';
  }

  factory UserModel.createUser() {
    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: '',
      r: Random().nextInt(256),
      g: Random().nextInt(256),
      b: Random().nextInt(256),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      r: json['r'],
      g: json['g'],
      b: json['b'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'r': r,
      'g': g,
      'b': b,
    };
  }
}