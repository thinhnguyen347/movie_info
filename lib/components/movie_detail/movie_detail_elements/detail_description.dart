import 'package:flutter/material.dart';

Widget movieDescription({required String description}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          'Tóm tắt nội dung:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: description != ''
            ? Text(description, textAlign: TextAlign.justify)
            : const Center(
                child: Text('Đang cập nhật...', textAlign: TextAlign.center)),
      )
    ],
  );
}
