// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostSignUp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSignUp _$PostSignUpFromJson(Map<String, dynamic> json) {
  return PostSignUp(
    json['username'] as String,
    json['password'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['email'] as String,
  );
}

Map<String, dynamic> _$PostSignUpToJson(PostSignUp instance) =>
    <String, dynamic>{
      'username': instance.username,
      'first_name': instance.first_name,
      'password': instance.password,
      'last_name': instance.last_name,
      'email': instance.email,
    };

PostSignIn _$PostSignInFromJson(Map<String, dynamic> json) {
  return PostSignIn(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$PostSignInToJson(PostSignIn instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SearchPw _$SearchPwFromJson(Map<String, dynamic> json) {
  return SearchPw(
    json['email'] as String,
  );
}

Map<String, dynamic> _$SearchPwToJson(SearchPw instance) => <String, dynamic>{
      'email': instance.email,
    };

SearchPwCode _$SearchPwCodeFromJson(Map<String, dynamic> json) {
  return SearchPwCode(
    json['email'] as String,
    json['verify_code'] as String,
  );
}

Map<String, dynamic> _$SearchPwCodeToJson(SearchPwCode instance) =>
    <String, dynamic>{
      'email': instance.email,
      'verify_code': instance.verify_code,
    };

check_user_link _$check_user_linkFromJson(Map<String, dynamic> json) {
  return check_user_link(
    json['username'] as String,
  );
}

Map<String, dynamic> _$check_user_linkToJson(check_user_link instance) =>
    <String, dynamic>{
      'username': instance.username,
    };