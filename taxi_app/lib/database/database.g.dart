// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFlutterDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder databaseBuilder(String name) =>
      _$FlutterDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FlutterDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FlutterDatabaseBuilder(null);
}

class _$FlutterDatabaseBuilder {
  _$FlutterDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$FlutterDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FlutterDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FlutterDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$FlutterDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FlutterDatabase extends FlutterDatabase {
  _$FlutterDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao _personDaoInstance;

  PaymentDAO _paymentDaoInstance;

  NotificationDao _notificationDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Person` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `email` TEXT, `password` TEXT, `name` TEXT, `mobile` TEXT, `isTwoStepVerOn` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Payment` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `cardType` TEXT, `number` TEXT, `name` TEXT, `month` INTEGER, `year` INTEGER, `cvv` INTEGER, `displayString` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MobileNotification` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `isAccountAndTripUpdatesOn` INTEGER, `isDiscountAndNewsOn` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }

  @override
  PaymentDAO get paymentDao {
    return _paymentDaoInstance ??= _$PaymentDAO(database, changeListener);
  }

  @override
  NotificationDao get notificationDao {
    return _notificationDaoInstance ??=
        _$NotificationDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _personInsertionAdapter = InsertionAdapter(
            database,
            'Person',
            (Person item) => <String, dynamic>{
                  'id': item.id,
                  'email': item.email,
                  'password': item.password,
                  'name': item.name,
                  'mobile': item.mobile,
                  'isTwoStepVerOn': item.isTwoStepVerOn == null
                      ? null
                      : (item.isTwoStepVerOn ? 1 : 0)
                }),
        _personUpdateAdapter = UpdateAdapter(
            database,
            'Person',
            ['id'],
            (Person item) => <String, dynamic>{
                  'id': item.id,
                  'email': item.email,
                  'password': item.password,
                  'name': item.name,
                  'mobile': item.mobile,
                  'isTwoStepVerOn': item.isTwoStepVerOn == null
                      ? null
                      : (item.isTwoStepVerOn ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _personMapper = (Map<String, dynamic> row) => Person(
      row['id'] as int,
      row['email'] as String,
      row['password'] as String,
      row['name'] as String,
      row['mobile'] as String,
      row['isTwoStepVerOn'] == null
          ? null
          : (row['isTwoStepVerOn'] as int) != 0);

  final InsertionAdapter<Person> _personInsertionAdapter;

  final UpdateAdapter<Person> _personUpdateAdapter;

  @override
  Future<List<Person>> findAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM Person ORDER BY id',
        mapper: _personMapper);
  }

  @override
  Future<Person> findPersonByEmailAndPassword(
      String email, String password) async {
    return _queryAdapter.query(
        'SELECT * FROM Person WHERE email = ? AND password = ?',
        arguments: <dynamic>[email, password],
        mapper: _personMapper);
  }

  @override
  Future<Person> findPersonByEmail(String email) async {
    return _queryAdapter.query('SELECT * FROM Person WHERE email = ?',
        arguments: <dynamic>[email], mapper: _personMapper);
  }

  @override
  Future<void> deletePerson(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM Person WHERE id =?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<int> insertPerson(Person person) {
    return _personInsertionAdapter.insertAndReturnId(
        person, OnConflictStrategy.abort);
  }

  @override
  Future<int> updatePerson(Person person) {
    return _personUpdateAdapter.updateAndReturnChangedRows(
        person, OnConflictStrategy.abort);
  }
}

class _$PaymentDAO extends PaymentDAO {
  _$PaymentDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _paymentInsertionAdapter = InsertionAdapter(
            database,
            'Payment',
            (Payment item) => <String, dynamic>{
                  'id': item.id,
                  'userId': item.userId,
                  'cardType': item.cardType,
                  'number': item.number,
                  'name': item.name,
                  'month': item.month,
                  'year': item.year,
                  'cvv': item.cvv,
                  'displayString': item.displayString
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _paymentMapper = (Map<String, dynamic> row) => Payment(
      row['id'] as int,
      row['userId'] as int,
      row['cardType'] as String,
      row['number'] as String,
      row['name'] as String,
      row['month'] as int,
      row['year'] as int,
      row['cvv'] as int,
      row['displayString'] as String);

  final InsertionAdapter<Payment> _paymentInsertionAdapter;

  @override
  Future<List<Payment>> findAllPayments() async {
    return _queryAdapter.queryList('SELECT * FROM Payment ORDER BY id ASC',
        mapper: _paymentMapper);
  }

  @override
  Future<List<Payment>> findPaymentByUserId(int userId) async {
    return _queryAdapter.queryList('SELECT * FROM Payment WHERE userId = ?',
        arguments: <dynamic>[userId], mapper: _paymentMapper);
  }

  @override
  Future<Payment> findPaymentByCardNo(String number) async {
    return _queryAdapter.query('SELECT * FROM Payment WHERE number = ?',
        arguments: <dynamic>[number], mapper: _paymentMapper);
  }

  @override
  Future<int> insertPerson(Payment payment) {
    return _paymentInsertionAdapter.insertAndReturnId(
        payment, OnConflictStrategy.abort);
  }
}

class _$NotificationDao extends NotificationDao {
  _$NotificationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _mobileNotificationInsertionAdapter = InsertionAdapter(
            database,
            'MobileNotification',
            (MobileNotification item) => <String, dynamic>{
                  'id': item.id,
                  'userId': item.userId,
                  'isAccountAndTripUpdatesOn':
                      item.isAccountAndTripUpdatesOn == null
                          ? null
                          : (item.isAccountAndTripUpdatesOn ? 1 : 0),
                  'isDiscountAndNewsOn': item.isDiscountAndNewsOn == null
                      ? null
                      : (item.isDiscountAndNewsOn ? 1 : 0)
                }),
        _mobileNotificationUpdateAdapter = UpdateAdapter(
            database,
            'MobileNotification',
            ['id'],
            (MobileNotification item) => <String, dynamic>{
                  'id': item.id,
                  'userId': item.userId,
                  'isAccountAndTripUpdatesOn':
                      item.isAccountAndTripUpdatesOn == null
                          ? null
                          : (item.isAccountAndTripUpdatesOn ? 1 : 0),
                  'isDiscountAndNewsOn': item.isDiscountAndNewsOn == null
                      ? null
                      : (item.isDiscountAndNewsOn ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _mobileNotificationMapper = (Map<String, dynamic> row) =>
      MobileNotification(
          row['id'] as int,
          row['userId'] as int,
          row['isAccountAndTripUpdatesOn'] == null
              ? null
              : (row['isAccountAndTripUpdatesOn'] as int) != 0,
          row['isDiscountAndNewsOn'] == null
              ? null
              : (row['isDiscountAndNewsOn'] as int) != 0);

  final InsertionAdapter<MobileNotification>
      _mobileNotificationInsertionAdapter;

  final UpdateAdapter<MobileNotification> _mobileNotificationUpdateAdapter;

  @override
  Future<MobileNotification> findNotificationByUserId(int userId) async {
    return _queryAdapter.query(
        'SELECT * FROM MobileNotification WHERE userId = ?',
        arguments: <dynamic>[userId],
        mapper: _mobileNotificationMapper);
  }

  @override
  Future<int> insertNotification(MobileNotification notification) {
    return _mobileNotificationInsertionAdapter.insertAndReturnId(
        notification, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateNotification(MobileNotification notification) {
    return _mobileNotificationUpdateAdapter.updateAndReturnChangedRows(
        notification, OnConflictStrategy.abort);
  }
}
