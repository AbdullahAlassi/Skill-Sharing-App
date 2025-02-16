import 'package:mongo_dart/mongo_dart.dart';
import 'package:bcrypt/bcrypt.dart'; // Password hashing library

class MongoDBService {
  static late Db db;
  static late DbCollection usersCollection;

  /// 🔹 Connect to MongoDB
  static Future<void> connect() async {
    try {
      db = await Db.create('mongodb://127.0.0.1:27017/skillapp');
      await db.open();
      print('✅ Connected to MongoDB');

      usersCollection = db.collection('users');
    } catch (e) {
      print('❌ MongoDB connection error: $e');
    }
  }

  /// 🔹 Insert a new user with a hashed password
  static Future<Map<String, dynamic>> insertUser(String name, String email, String password) async {
    try {
      final collection = db.collection('users');

      // Check if the user already exists
      final existingUser = await collection.findOne({'email': email.toLowerCase()});
      if (existingUser != null) {
        return {'success': false, 'error': 'User already exists'};
      }

      // ✅ Hash the password securely with a proper salt
      String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(logRounds: 12));

      Map<String, dynamic> user = {
        '_id': ObjectId().toHexString(), // Store ObjectId as String
        'name': name,
        'email': email.toLowerCase(), // Store email in lowercase
        'password': hashedPassword, // Store hashed password
      };

      var result = await collection.insertOne(user);

      return result.isSuccess
          ? {'success': true, 'insertedId': user['_id']}
          : {'success': false, 'error': 'Insert failed'};
    } catch (e) {
      print('❌ Insert error: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// 🔹 Fetch all users
  static Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      final collection = db.collection('users');
      final documents = await collection.find().toList();

      return documents.map((doc) {
        if (doc['_id'] is ObjectId) {
          doc['_id'] = (doc['_id'] as ObjectId).toHexString(); // Convert ObjectId to String
        }
        return doc;
      }).toList();
    } catch (e) {
      print('❌ Fetch error: $e');
      return [];
    }
  }

  /// 🔹 Login user (Validate email and password)
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final collection = db.collection('users');
      final user = await collection.findOne({'email': email.toLowerCase()});

      if (user == null) {
        return {'success': false, 'error': 'User not found'};
      }

      // ✅ Check if the password field exists before verification
      if (!user.containsKey('password') || user['password'].isEmpty) {
        return {'success': false, 'error': 'Invalid credentials'};
      }

      // ✅ Compare entered password with stored hashed password
      bool isPasswordValid = BCrypt.checkpw(password, user['password']);

      if (!isPasswordValid) {
        return {'success': false, 'error': 'Invalid password'};
      }

      return {'success': true, 'userId': user['_id'], 'name': user['name']};
    } catch (e) {
      print('❌ Login error: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// 🔹 Generic Insert Function
  static Future<Map<String, dynamic>> insert(String collectionName, Map<String, dynamic> data) async {
    try {
      final collection = db.collection(collectionName);
      data['_id'] = ObjectId().toHexString(); // Store ObjectId as String

      var result = await collection.insertOne(data);

      return result.isSuccess
          ? {'success': true, 'insertedId': data['_id']}
          : {'success': false, 'error': 'Insert failed'};
    } catch (e) {
      print('❌ Insert error: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// 🔹 Generic Fetch Function
  static Future<List<Map<String, dynamic>>> fetch(String collectionName, [Map<String, dynamic>? filter]) async {
    try {
      final collection = db.collection(collectionName);
      final documents = await collection.find(filter ?? {}).toList();

      return documents.map((doc) {
        if (doc['_id'] is ObjectId) {
          doc['_id'] = (doc['_id'] as ObjectId).toHexString();
        }
        return doc;
      }).toList();
    } catch (e) {
      print('❌ Fetch error: $e');
      return [];
    }
  }
}
