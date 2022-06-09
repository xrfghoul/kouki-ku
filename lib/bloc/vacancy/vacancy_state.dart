part of 'vacancy_cubit.dart';

@immutable
abstract class VacancyState extends Equatable {
  final List<Vacancy> vacancyList;
  final List<Vacancy> ownedVacancyList;
  final List<VacancySubmission> restaurantVacancySubmissionList;
  final Vacancy? selectedVacancy;

  VacancyState({
    required this.vacancyList,
    required this.ownedVacancyList,
    required this.restaurantVacancySubmissionList,
    this.selectedVacancy,
  });

  @override
  List<Object?> get props => [
        vacancyList,
        ownedVacancyList,
        restaurantVacancySubmissionList,
        selectedVacancy
      ];
}

class VacancyInitial extends VacancyState {
  VacancyInitial({
    required List<Vacancy> vacancyList,
    required List<Vacancy> ownedVacancyList,
    required List<VacancySubmission> restaurantVacancySubmissionList,
  }) : super(
            vacancyList: vacancyList,
            ownedVacancyList: ownedVacancyList,
            restaurantVacancySubmissionList: restaurantVacancySubmissionList);
  @override
  List<Object?> get props =>
      [vacancyList, restaurantVacancySubmissionList, selectedVacancy];
}

class VacancyFetchSuccess extends VacancyState {
  VacancyFetchSuccess({
    required List<Vacancy> vacancyList,
    required List<Vacancy> ownedVacancyList,
    required List<VacancySubmission> restaurantVacancySubmissionList,
  }) : super(
            vacancyList: vacancyList,
            ownedVacancyList: ownedVacancyList,
            restaurantVacancySubmissionList: restaurantVacancySubmissionList);
  @override
  List<Object?> get props =>
      [vacancyList, restaurantVacancySubmissionList, selectedVacancy];
}

class VacancyFetchFailure extends VacancyState {
  VacancyFetchFailure({
    required List<Vacancy> vacancyList,
    required List<Vacancy> ownedVacancyList,
    required List<VacancySubmission> restaurantVacancySubmissionList,
  }) : super(
            vacancyList: vacancyList,
            ownedVacancyList: ownedVacancyList,
            restaurantVacancySubmissionList: restaurantVacancySubmissionList);
  @override
  List<Object?> get props =>
      [vacancyList, restaurantVacancySubmissionList, selectedVacancy];
}

class VacancyLoading extends VacancyState {
  VacancyLoading({
    required List<Vacancy> vacancyList,
    required List<Vacancy> ownedVacancyList,
    required List<VacancySubmission> restaurantVacancySubmissionList,
  }) : super(
            vacancyList: vacancyList,
            ownedVacancyList: ownedVacancyList,
            restaurantVacancySubmissionList: restaurantVacancySubmissionList);
  @override
  List<Object?> get props =>
      [vacancyList, restaurantVacancySubmissionList, selectedVacancy];
}

class VacancyCreateSuccess extends VacancyState {
  VacancyCreateSuccess({
    required List<Vacancy> vacancyList,
    required List<Vacancy> ownedVacancyList,
    required List<VacancySubmission> restaurantVacancySubmissionList,
  }) : super(
            vacancyList: vacancyList,
            ownedVacancyList: ownedVacancyList,
            restaurantVacancySubmissionList: restaurantVacancySubmissionList);
  @override
  List<Object?> get props =>
      [vacancyList, restaurantVacancySubmissionList, selectedVacancy];
}

class VacancyCreateFailure extends VacancyState {
  final String message;
  VacancyCreateFailure({
    required this.message,
    required List<Vacancy> vacancyList,
    required List<Vacancy> ownedVacancyList,
    required List<VacancySubmission> restaurantVacancySubmissionList,
  }) : super(
            vacancyList: vacancyList,
            ownedVacancyList: ownedVacancyList,
            restaurantVacancySubmissionList: restaurantVacancySubmissionList);
  @override
  List<Object?> get props =>
      [vacancyList, restaurantVacancySubmissionList, selectedVacancy];
}
