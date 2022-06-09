part of 'vacancy.dart';

class VacancyDetail extends StatelessWidget {
  const VacancyDetail({Key? key, required this.vacancy}) : super(key: key);

  final Vacancy vacancy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Lowongan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            // if (vacancy.restaurantPhoto.trim().isNotEmpty)
            Align(
              child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                  child: (vacancy.restaurantPhoto.trim().isNotEmpty)
                      ? Image.network(
                          vacancy.restaurantPhoto,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text("No Image"),
                        )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(vacancy.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(vacancy.type,
                style: TextStyle(
                    color: vacancy.type == Vacancy.kerjaType
                        ? Colors.blue
                        : Colors.green)),
            Row(
              children: [
                Text("Gaji "),
                Text(FormatUtils.formatAmount(vacancy.salary),
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(vacancy.description),
            Divider(
              thickness: 2,
            ),
            Text("Kualifikasi", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            ...vacancy.requirement.map((e) => Row(
                  children: [
                    Text('- '),
                    Text('$e'),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
