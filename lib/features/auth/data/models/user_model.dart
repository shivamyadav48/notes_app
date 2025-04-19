import 'package:json_annotation/json_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  UserModel({
    required String id,
    required String name,
    required String email,
    String? photoUrl,
  }) : super(id: id, name: name, email: email, photoUrl: photoUrl);

  factory UserModel.fromGoogleSignInAccount(GoogleSignInAccount account) {
    return UserModel(
      id: account.id,
      name: account.displayName ?? '',
      email: account.email,
      photoUrl: account.photoUrl,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
