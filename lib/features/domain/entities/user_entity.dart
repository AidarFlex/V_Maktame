import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userID;
  final String userName;
  final String email;
  final String password;

  const UserEntity(
      {required this.userID,
      required this.userName,
      required this.email,
      required this.password});

  @override
  List<Object> get props => [
        userID,
        userName,
        email,
      ];
}
