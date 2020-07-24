import 'package:floor/floor.dart';

@entity
class Person{
  @PrimaryKey(autoGenerate: true)
  int id;
  String email;
  String password;
  String name;
  String mobile;

  Person(this.id, this.email, this.password, this.name, this.mobile);

  @override
  String toString() {
    return 'Person{id: $id, email: $email, password: $password, name: $name, mobile: $mobile}';
  }
}