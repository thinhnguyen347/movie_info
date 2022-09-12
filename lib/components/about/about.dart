import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authorInfo = {
      "name": "Nguyen Duc Thinh",
      "email": "nd.thinh91@gmail.com",
      "phone": "098401891"
    };
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            infoBar(title: "Người thực hiện", content: authorInfo["name"]),
            const SizedBox(height: 10),
            infoBar(title: "Email", content: authorInfo["email"]),
            const SizedBox(height: 10),
            infoBar(title: "Số điện thoại", content: authorInfo["phone"]),
          ],
        ));
  }
}

Widget infoBar({required String title, required dynamic content}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Row(children: [Text("$title :"), Text(content)]),
      ),
    ),
  );
}
