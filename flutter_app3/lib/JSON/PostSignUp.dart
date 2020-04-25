import 'package:json_annotation/json_annotation.dart';
part 'PostSignUp.g.dart';

@JsonSerializable()
class PostSignUp{
  PostSignUp(this.username, this.password,this.first_name, this.last_name, this.email);
  String username;
  String first_name;
  String password;
  String last_name;
  String email;

  factory PostSignUp.fromJson(Map<String, dynamic> json) => _$PostSignUpFromJson(json);
  Map<String, dynamic> toJson() => _$PostSignUpToJson(this);

}

@JsonSerializable()
class PostSignIn{
  PostSignIn(this.username, this.password);
  String username;
  String password;
  factory PostSignIn.fromJson(Map<String, dynamic> json) => _$PostSignInFromJson(json);
  Map<String, dynamic> toJson() => _$PostSignInToJson(this);
}

@JsonSerializable()
class SearchPw{
  SearchPw(this.email);
  String email;
  factory SearchPw.fromJson(Map<String, dynamic> json) => _$SearchPwFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPwToJson(this);
}

@JsonSerializable()
class SearchPwCode{
  SearchPwCode(this.email, this.verify_code);
  String email;
  String verify_code;
  factory SearchPwCode.fromJson(Map<String, dynamic> json) => _$SearchPwCodeFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPwCodeToJson(this);
}

@JsonSerializable()
class check_user_link{
  check_user_link(this.username);
  String username;
  factory check_user_link.fromJson(Map<String, dynamic> json) => _$check_user_linkFromJson(json);
  Map<String, dynamic> toJson() => _$check_user_linkToJson(this);
}

@JsonSerializable()
class SearchList{
  SearchList();
  factory SearchList.fromJson(Map<String, dynamic> json) => _$SearchListFromJson(json);
  Map<String, dynamic> toJson() => _$SearchListToJson(this);
}
