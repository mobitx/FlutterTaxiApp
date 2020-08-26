import 'package:taxiapp/database/model/person.dart';
import 'package:floor/floor.dart';

@dao
abstract class PersonDao{
  @Query('SELECT * FROM Person ORDER BY id')
  Future<List<Person>> findAllPersons();

  @Query('SELECT * FROM Person WHERE email = :email AND password = :password')
  Future<Person> findPersonByEmailAndPassword(String email, String password);

  @Query('SELECT * FROM Person WHERE email = :email')
  Future<Person> findPersonByEmail(String email);

  @insert
  Future<int> insertPerson(Person person);

  @update
  Future<int> updatePerson(Person person);

  @Query('DELETE FROM Person WHERE id =:id')
  Future<void> deletePerson(int id);
  //flutter packages pub run build_runner build
}