import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardingData {
  String name = '';
  int? age;
  String gender = '';
  double? heightCm;
  double? weightKg;
  double? bmi;
  String goal = '';
  String experience = '';
  String location = '';
  List<String> workoutDays = [];
  List<String> equipment = [];
  String workoutDuration = '';

  // Health Screening fields
  bool hasHealthConcern = false;
  String? healthBodyPart;
  String? healthIssueType;
  String? healthStatus;
  String? healthNotes;

  static final OnboardingData instance = OnboardingData._internal();
  OnboardingData._internal();

  Map<String, dynamic> toFirestoreMap() {
    final Map<String, dynamic> healthScreeningData = {
      'hasHealthConcern': hasHealthConcern,
    };
    if (hasHealthConcern) {
      healthScreeningData['bodyPart'] = healthBodyPart ?? '';
      healthScreeningData['issueType'] = healthIssueType ?? '';
      healthScreeningData['status'] = healthStatus ?? '';
      healthScreeningData['notes'] = healthNotes ?? '';
    }

    return {
      'name': name,
      'age': age,
      'gender': gender,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'bmi': bmi,
      'goal': goal,
      'experience': experience,
      'location': location,
      'workoutDays': workoutDays,
      'equipment': equipment,
      'workoutDuration': workoutDuration,
      'healthScreening': healthScreeningData,
      'onboardingCompleted': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class OnboardingService {
  OnboardingService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<void> saveOnboardingData(OnboardingData data) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw Exception('No authenticated user found. Please log in first.');
    }

    await _firestore
        .collection('users')
        .doc(uid)
        .set(data.toFirestoreMap(), SetOptions(merge: true));
  }
}
