part of '../home.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
        bloc: context.read<AuthenticationCubit>(),
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(child: _buildProfile(state)),
                if (state is VacancyLoading) ..._loadingFront()
              ],
            ),
          );
        });
  }

  Widget _buildProfile(AuthenticationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _header(),
        SizedBox(
          height: 20,
        ),
        if (state.currentUser != null) _userInfo(state.currentUser!),
        if (state.currentUser != null)
          SizedBox(
            height: 20,
          ),
        _actionListWidget()
      ],
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
          _actionComponent("Daftar Pelamar", () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const VacancySubmissionScreen())));
          }),
          // _actionComponent("Konfirmasi Status Pelamar", () {
          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //       backgroundColor: Colors.blue,
          //       duration: Duration(seconds: 2),
          //       content: Text("Fitur belum tersedia")));
          // }),
          _actionComponent("Kontak Admin", () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => const ContactAdmin())));
          }),
          _actionComponent("Logout", () {
            context.read<AuthenticationCubit>().logOut();
          }, iconData: Icons.exit_to_app_outlined),
        ],
      ),
    );
  }

  Widget _actionComponent(String text, VoidCallback onTap,
      {IconData? iconData}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.blueAccent,
            border: Border(bottom: BorderSide(color: Colors.white))),
        child: Row(
          children: [
            if (iconData != null) Icon(iconData, color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text,
                  style: Constant.labelStyleOnDarkColor.copyWith(fontSize: 16)),
            ),
          ],
        ),
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
