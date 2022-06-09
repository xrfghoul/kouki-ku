part of 'auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  late final AuthenticationCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = context.read<AuthenticationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: _authListener,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Align(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                    child: const Text(
                  'KokiKu',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  controller: _emailController,
                  hint: 'Email',
                ),
                CustomTextField(
                  controller: _passController,
                  obscure: true,
                  hint: 'Password',
                ),
                SizedBox(
                  height: 25,
                ),
                ElevatedButton(onPressed: _login, child: Text("Masuk")),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Belum Memiliki Akun? Registrasi Disini"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login() {
    authCubit.loginWithEmail(
        email: _emailController.text.trim(),
        password: _passController.text.trim());
  }

  _authListener(BuildContext context, AuthenticationState state) {
    if (state is AuthenticationFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          state.error,
        ),
        backgroundColor: Colors.red,
      ));
    }
    if (state is AuthenticationSuccess) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: ((context) => const HomeScreen())),
          (Route<dynamic> route) => false);
    }
  }
}
