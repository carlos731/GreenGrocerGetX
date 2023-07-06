import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: 'fullname')
  String? name;
  String? email;
  String? phone;
  String? cpf;
  String? password;
  String? id;
  String? token;

  UserModel({
    this.phone,
    this.cpf,
    this.email,
    this.name,
    this.password,
    this.id,
    this.token,
  });

  /* Não é mais necessário, pois algumas libs ja fazem isso para nós logo abaixo.
  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      cpf: map['cpf'],
      email: map['email'],
      id: map['id'],
      name: map['fullname'],
      password: map['password'],
      phone: map['phone'],
      token: map['token'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'cpf': cpf,
      'email': email,
      'id': id,
      'fullname': name,
      'password': password,
      'phone': phone,
      'token': token,
    };
  }
  */

  // para gerar o build com a lib build_runner, no terminal colocar para criar o arquivo user_model.g.dart: flutter pub run build_runner build
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);


  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, phone: $phone, cpf: $cpf, password: $password, id: $id, token: $token)';
  }
}
