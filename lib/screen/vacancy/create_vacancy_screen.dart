part of 'vacancy.dart';

class CreateVacancyScreen extends StatefulWidget {
  const CreateVacancyScreen({Key? key}) : super(key: key);

  @override
  State<CreateVacancyScreen> createState() => _CreateVacancyScreenState();
}

class _CreateVacancyScreenState extends State<CreateVacancyScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _salaryController = TextEditingController();
  final _requirementListController = [TextEditingController()];
  final ImagePicker _imagePicker = ImagePicker();
  Uint8List? pickedImage;
  String type = Vacancy.kerjaType;

  Future<void> _pickImage() async {
    final xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      pickedImage = await xFile.readAsBytes();
    }
    setState(() {});
  }

  void _submit() {
    final ownerId = context.read<AuthenticationCubit>().state.currentUser?.id;
    if (ownerId == null) {
      return;
    }

    final vacancy = Vacancy(
        id: '',
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        ownerId: ownerId,
        postedAt: DateTime.now(),
        requirement:
            _requirementListController.map((e) => e.text.trim()).toList(),
        restaurantPhoto: '',
        salary: int.tryParse(_salaryController.text) ?? 0,
        type: type);
    context.read<VacancyCubit>().createVacancy(vacancy, img: pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VacancyCubit, VacancyState>(
      listener: (context, state) {
        if (state is VacancyCreateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Sukses"),
            backgroundColor: Colors.green,
          ));
          Navigator.of(context).pop();
        }
        if (state is VacancyCreateFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Buat Lowongan'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Align(
            child: ListView(
              children: [
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
                  controller: _nameController,
                  hint: 'Nama Lowongan',
                ),
                CustomTextField(
                  controller: _descriptionController,
                  hint: 'Deskripsi',
                ),
                Row(
                  children: [
                    Text('Kualifikasi'),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _requirementListController
                                .add(TextEditingController());
                          });
                        },
                        child: Icon(Icons.add))
                  ],
                ),
                ..._requirementListController.map((e) {
                  return CustomTextField(
                    controller: e,
                  );
                }).toList(),
                CustomTextField(
                  controller: _salaryController,
                  isNumber: true,
                  hint: 'Gaji',
                ),
                Row(
                  children: [
                    Radio<String>(
                        value: Vacancy.kerjaType,
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = value ?? Vacancy.kerjaType;
                          });
                        }),
                    Text('Kerja')
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                        value: Vacancy.magangType,
                        groupValue: type,
                        onChanged: (value) {
                          setState(() {
                            type = value ?? Vacancy.magangType;
                          });
                        }),
                    Text('Magang')
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                BlocBuilder<VacancyCubit, VacancyState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        onPressed: (state is VacancyLoading) ? null : _submit,
                        child: (state is VacancyLoading)
                            ? Align(
                                child: const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(),
                              ))
                            : Text("Submit"));
                  },
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
