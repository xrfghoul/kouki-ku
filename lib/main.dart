import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kokiku/bloc/authentication/authentication_cubit.dart';
import 'package:kokiku/bloc/submission/submission_cubit.dart';
import 'package:kokiku/bloc/vacancy/vacancy_cubit.dart';
import 'package:kokiku/screen/auth/auth.dart';
import 'package:kokiku/service_implementation/authentication_service_impl.dart';
import 'package:kokiku/service_implementation/submission_service_impl.dart';
import 'package:kokiku/service_implementation/vacancy_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthenticationCubit authBloc;
  late final VacancyCubit vacancyCubit;
  late final SubmissionCubit submissionCubit;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    super.initState();
    authBloc = AuthenticationCubit(AuthenticationServiceImpl());
    vacancyCubit = VacancyCubit(VacancyServiceImpl(), SubmissionServiceImpl());
    submissionCubit = SubmissionCubit(SubmissionServiceImpl());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => authBloc,
        ),
        BlocProvider(
          create: (context) => vacancyCubit,
        ),
        BlocProvider(
          create: (context) => submissionCubit,
        ),
      ],
      child: MaterialApp(
        title: 'Kokiku',
        home: SplashScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
