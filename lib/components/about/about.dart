import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authorInfo = {
      "name": "Nguyen Duc Thinh",
      "email": "nd.thinh91@gmail.com",
      "phone": "098401891"
    };

    final SpringController springController =
        SpringController(initialAnim: Motion.play);

    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              "Cảm ơn mọi người đã trải nghiệm ứng dụng. Mọi góp ý cải thiện sản phẩm xin vui lòng liên hệ theo thông tin dưới đây:",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Spring.slide(
              springController: springController,
              slideType: SlideType.slide_in_left,
              withFade: true,
              animDuration: const Duration(milliseconds: 1000),
              child: infoBar(
                  title: "Người thực hiện", content: authorInfo["name"]),
            ),
            const SizedBox(height: 10),
            Spring.slide(
                springController: springController,
                slideType: SlideType.slide_in_left,
                withFade: true,
                animDuration: const Duration(milliseconds: 1500),
                child: infoBar(title: "Email", content: authorInfo["email"])),
            const SizedBox(height: 10),
            Spring.slide(
                springController: springController,
                slideType: SlideType.slide_in_left,
                withFade: true,
                animDuration: const Duration(milliseconds: 2000),
                child: infoBar(
                    title: "Số điện thoại", content: authorInfo["phone"]))
          ],
        ));
  }
}

Widget infoBar({required String title, required dynamic content}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(children: [Text("$title: "), Text(content)]),
      ),
    ),
  );
}
