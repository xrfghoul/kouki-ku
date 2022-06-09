part of '../home.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final searchController = TextEditingController();
  List<Vacancy> filteredList = [];
  String? keyword;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VacancyCubit, VacancyState>(
        bloc: context.read<VacancyCubit>(),
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(child: _buildSearch(state)),
                if (state is VacancyLoading) ..._loadingFront()
              ],
            ),
          );
        });
  }

  Widget _buildSearch(VacancyState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TextField(
            controller: searchController,
            onSubmitted: (str) {
              keyword = str;
              filteredList = state.vacancyList
                  .where((element) => element.name.toLowerCase().contains(str))
                  .toList();
              setState(() {});
            },
            decoration: InputDecoration(
                hintText: "Cari lowongan",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search)),
          ),
        ),
        Expanded(child: _buildVacancyList(filteredList))
      ],
    );
  }

  Widget _buildVacancyList(List<Vacancy> vacancyList) {
    if (vacancyList.isEmpty) {
      return const Center(
        child: Text('Lowongan Tidak ditemukan'),
      );
    }

    return Column(
      children: [
        if (keyword != null)
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text("Hasil pencarian '$keyword'"),
              )),
        Expanded(
          child: ListView.builder(
            itemCount: vacancyList.length,
            itemBuilder: (context, i) {
              return _vacancyComponent(vacancyList[i]);
            },
          ),
        ),
      ],
    );
  }

  Widget _vacancyComponent(Vacancy vacancy) {
    return Card(
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
            Text(Constant.dateToString(vacancy.postedAt)),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: Center(
          child: Text(
        "Mitra - KokiKu",
        style: Constant.labelStyleOnDarkColor,
      )),
    );
  }

  Widget _userInfo(User user) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: CircleAvatar(
            radius: 30,
            backgroundImage: user.image != null
                ? NetworkImage(
                    user.image ?? '',
                  )
                : Image.asset('profile_placeholder.png').image,
          )),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.restaurantName,
                    style: Constant.labelStyleOnDarkColor
                        .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.blue,
                          duration: Duration(seconds: 2),
                          content: Text("Fitur belum tersedia")));
                    },
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.white, size: 18),
                        Text(
                          "Ubah Profil",
                          style: Constant.labelStyleOnDarkColor.copyWith(
                              fontSize: 15, fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  )
                  // TextButton.icon(
                  //     onPressed: () {
                  //       //TODO
                  //     },
                  //     icon: Text(
                  //       "Ubah Profile",
                  //       style: Constant.labelStyleOnDarkColor.copyWith(
                  //           fontSize: 16, fontWeight: FontWeight.normal),
                  //     ),
                  //     label: Icon(Icons.edit, color: Colors.white, size: 20))
                ],
              ))
        ],
      ),
    );
  }

  Widget _actionListWidget() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: Column(
        children: [
          _actionComponent("Buat Lowongan", () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const CreateVacancyScreen())));
          }),
          _actionComponent("Cek Daftar Pelamar", () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const VacancySubmissionScreen())));
          }),
          _actionComponent("Konfirmasi Status Pelamar", () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 2),
                content: Text("Fitur belum tersedia")));
          }),
          _actionComponent("Kontak Admin", () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 2),
                content: Text("Fitur belum tersedia")));
          }),
        ],
      ),
    );
  }

  Widget _actionComponent(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Text(text,
            style: Constant.labelStyleOnDarkColor.copyWith(fontSize: 16)),
      ),
    );
  }

  List<Widget> _loadingFront() {
    return [
      const Opacity(
        opacity: 0.5,
        child: ModalBarrier(dismissible: false, color: Colors.black),
      ),
      const Center(
        child: CircularProgressIndicator(),
      )
    ];
  }
}
