part of 'auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _ownerController = TextEditingController();
  final _restaurantNameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? pickedImage;

  Future<void> _pickImage() async {
    final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      pickedImage = await xFile.readAsBytes();
    }
    setState(() {});
  }

  void _submitRegis() {
    //TODO: Validation
    final user = User(
      email: _emailController.text.trim().toLowerCase(),
      id: '',
      name: _ownerController.text.trim(),
      restaurantName: _restaurantNameController.text.trim(),
      role: User.restaurantOwnerRole,
    );
    context.read<AuthenticationCubit>().register(user,
        password: _passController.text.trim(), image: pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Align(
          child: ListView(
            children: [
              // Center(
              //     child: const Text(
              //   'KokiKu',
              //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              // )),
              SizedBox(
                height: 10,
              ),
              Align(
                child: InkWell(
                  onTap: _pickImage,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: pickedImage != null
                        ? Image.memory(
                            pickedImage!,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image),
                  ),
                ),
              ),
              CustomTextField(
                controller: _ownerController,
                hint: 'Nama Pemilik',
              ),
              CustomTextField(
                controller: _restaurantNameController,
                hint: 'Nama Restoran',
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
              ElevatedButton(
                  onPressed: _submitRegis, child: Text("Registrasi")),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
