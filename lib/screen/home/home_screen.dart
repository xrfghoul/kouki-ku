part of 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    if (context.read<AuthenticationCubit>().state.currentUser == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const LoginScreen())));
    } else {
      // context.read<AuthenticationCubit>().state.currentUser!.id
      context.read<VacancyCubit>().loadAllVacancy();
    }
  }

  _authListener(BuildContext context, AuthenticationState state) {
    if (state is LogoutSuccess) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const LoginScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _authListener,
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: _currentIndex != 0
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => const CreateVacancyScreen())));
                  },
                  child: Icon(Icons.add),
                ),
          body: Center(child: indexWidget(context, _currentIndex)),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                  label: 'Search', icon: Icon(Icons.search)),
              BottomNavigationBarItem(
                  label: 'Profile', icon: Icon(Icons.person)),
            ],
          ),
        ),
      ),
    );
  }

  Widget indexWidget(BuildContext context, int index) {
    switch (index) {
      case 0:
        return const HomeWidget();
      case 1:
        return const SearchWidget();
      case 2:
        return const ProfileWidget();
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Soon'),
            const SizedBox(
              height: 60,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  context.read<AuthenticationCubit>().logOut();
                },
                child: Text('Logout'))
          ],
        );
    }
  }
}
