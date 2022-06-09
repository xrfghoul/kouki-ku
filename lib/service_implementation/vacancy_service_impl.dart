import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:kokiku/model/user.dart';
import 'package:kokiku/model/vacancy.dart';
import 'package:kokiku/service/authentication_service.dart';
import 'package:kokiku/service/vacancy_service.dart';

import '../utils/storage_utils.dart';

class VacancyServiceImpl extends VacancyApi {
  final vacancyCollection = FirebaseFirestore.instance.collection('vacancy');

  @override
  Future<Vacancy?> createVacancy(Vacancy vacancy, Uint8List? img) async {
    final docRef = vacancyCollection.doc();
    final vacancyId = docRef.id;
    if (img != null) {
      final imageUrl = await StorageUtils.uploadImage(img, vacancyId);
      vacancy = vacancy.copyWith(restaurantPhoto: imageUrl);
    }
    vacancy = vacancy.copyWith(id: vacancyId);
    await docRef.set(vacancy.toMap());
    return vacancy;
  }

  @override
  Stream<List<Vacancy>> loadVacancyByOwnerId(String ownerId) {
    final snap = vacancyCollection
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .asBroadcastStream();
    return snap.map((e) {
      if (e.docs.isEmpty) {
        return [];
      }
      return e.docs.map((x) => Vacancy.fromMap(x.data())).toList();
    });
  }

  @override
  Stream<List<Vacancy>> loadAllVacancy() {
    final snap = vacancyCollection.snapshots().asBroadcastStream();
    return snap.map((e) {
      if (e.docs.isEmpty) {
        return [];
      }
      return e.docs.map((x) => Vacancy.fromMap(x.data())).toList();
    });
  }
}
