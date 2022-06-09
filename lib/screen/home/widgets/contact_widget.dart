part of '../home.dart';

class ContactAdmin extends StatelessWidget {
  const ContactAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Admin"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Ahmad Rizqy", style: TextStyle(fontSize: 18)),
          SelectableText("085775774147",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          TextButton(
              style: TextButton.styleFrom(primary: Colors.green),
              onPressed: () {
                launchUrlString("https://wa.me/6285775774147?text=Hello",
                    mode: LaunchMode.externalNonBrowserApplication);
              },
              child: Text("Whatsapp"))
        ],
      )),
    );
  }
}
