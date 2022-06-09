part of 'vacancy.dart';

class VacancySubmissionScreen extends StatefulWidget {
  const VacancySubmissionScreen({Key? key}) : super(key: key);

  @override
  _VacancySubmissionScreenState createState() =>
      _VacancySubmissionScreenState();
}

class _VacancySubmissionScreenState extends State<VacancySubmissionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VacancyCubit>().loadOwnVacancy(
        context.read<AuthenticationCubit>().state.currentUser!.id);
    context.read<VacancyCubit>().loadVacancySubmission(
        context.read<AuthenticationCubit>().state.currentUser!.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacancyCubit, VacancyState>(builder: (context, state) {
      print(
          'state.restaurantVacancySubmissionList ${state.restaurantVacancySubmissionList}');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Pelamar'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Align(
            child: ListView(
                children: state.restaurantVacancySubmissionList
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(5),
                          child: _vacancyWidget(e),
                        ))
                    .toList()),
          ),
        ),
      );
    });
  }

  Widget _vacancyWidget(VacancySubmission vacancy) {
    return InkWell(
      onTap: () {
        // Submission submission = Submission(
        //     id: '',
        //     user: context.read<AuthenticationCubit>().state.currentUser!,
        //     vacancy: vacancy.vacancy,
        //     createdAt: DateTime.now(),
        //     status: Submission.submittedStatus);
        // context.read<SubmissionCubit>().addSubmission(submission);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  vacancy.vacancy.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    Submission submission = Submission(
                        id: '',
                        user: User(
                            id: "dummy",
                            name: "Pelamar Dummy",
                            email: "pelamardummy@gmail.com",
                            restaurantName: "Dummy",
                            role: User.restaurantOwnerRole),
                        vacancy: vacancy.vacancy,
                        createdAt: DateTime.now(),
                        status: Submission.submittedStatus);
                    context.read<SubmissionCubit>().addSubmission(submission);
                  },
                  child: Text("+ Pelamar"),
                )
              ],
            ),
            Text(vacancy.vacancy.description),
            Text(vacancy.vacancy.type,
                style: TextStyle(
                    color: vacancy.vacancy.type == Vacancy.kerjaType
                        ? Colors.blue
                        : Colors.green)),
            CustomExpansionTile(
                isDense: true,
                tilePadding: EdgeInsets.zero,
                children: vacancy.submissionList
                    .map((e) => _submissionComponent(e))
                    .toList(),
                title: Text("Daftar Pelamar"))
          ],
        ),
      ),
    );
  }

  Widget _submissionComponent(Submission submission) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.network(submission.user.image ?? '').image,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(submission.user.name),
              Text(submission.user.email, style: TextStyle(color: Colors.grey)),
              Text(submission.status, style: TextStyle(fontSize: 12)),
              if (submission.status == Submission.submittedStatus)
                Row(
                  children: [
                    TextButton(
                        style: TextButton.styleFrom(primary: Colors.red),
                        onPressed: () {
                          context.read<SubmissionCubit>().updateSubmission(
                              submission.copyWith(
                                  status: Submission.rejectStatus));
                        },
                        child: Text("Tolak")),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        style: TextButton.styleFrom(primary: Colors.green),
                        onPressed: () {
                          context.read<SubmissionCubit>().updateSubmission(
                              submission.copyWith(
                                  status: Submission.approvedStatus));
                        },
                        child: Text("Terima")),
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
