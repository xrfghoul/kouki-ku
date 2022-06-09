import 'dart:typed_data';

import 'package:kokiku/model/vacancy.dart';

abstract class VacancyApi {
  Future<Vacancy?> createVacancy(Vacancy vacancy, Uint8List? img);
  Stream<List<Vacancy>> loadVacancyByOwnerId(String ownerId);
  Stream<List<Vacancy>> loadAllVacancy();
}
