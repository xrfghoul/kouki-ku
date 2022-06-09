part of '../home.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacancyCubit, VacancyState>(
        bloc: context.read<VacancyCubit>(),
        builder: (context, state) {
          return Stack(
            children: [
              if (state is! VacancyLoading)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Daftar Lowongan',
                          style: Constant.labelStyleOnLightColor.copyWith(
                              color: Colors.blueAccent, fontSize: 17)),
                      const Divider(),
                      Expanded(child: _buildVacancyList(state.vacancyList)),
                    ],
                  ),
                ),
              if (state is VacancyLoading) ..._loadingFront()
            ],
          );
        });
  }

  Widget _buildVacancyList(List<Vacancy> vacancyList) {
    if (vacancyList.isEmpty) {
      return const Center(
        child: Text('Belum ada Lowongan'),
      );
    }

    return ListView.builder(
      itemCount: vacancyList.length,
      itemBuilder: (context, i) {
        return _vacancyComponent(vacancyList[i]);
      },
    );
  }

  Widget _vacancyComponent(Vacancy vacancy) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => VacancyDetail(vacancy: vacancy))));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(5),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10)
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(vacancy.name, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(vacancy.type,
                  style: TextStyle(
                      color: vacancy.type == Vacancy.kerjaType
                          ? Colors.blue
                          : Colors.green)),
              Text(vacancy.description),
              SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(Constant.dateToString(vacancy.postedAt))),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _loadingFront() {
    return [
      const Opacity(
        opacity: 0.5,
        child: ModalBarrier(dismissible: false, color: Colors.grey),
      ),
      const Center(
        child: CircularProgressIndicator(),
      )
    ];
  }
}
