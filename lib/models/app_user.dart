import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'app_user.g.dart';
abstract class AppUser implements Built<AppUser, AppUserBuilder>{
  factory AppUser([AppUserBuilder updates(AppUserBuilder builder)]) = _$AppUser;

  AppUser._();

  String get name;
  String get password;

  int get userId;

  @nullable
  String get accessToken;

  static Serializer<AppUser> get serializer => _$appUserSerializer;

}