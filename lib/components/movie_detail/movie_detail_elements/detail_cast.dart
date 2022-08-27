import 'package:flutter/material.dart';

import '../../../dataSrc/cast_service.dart';
import '../../../models/cast_model.dart';

Widget cast({required id, required context}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Diễn viên', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          width: double.infinity,
          child: FutureBuilder(
              future: getCastList(id: id),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return const Center(
                      child: Text('Không có dữ liệu!',
                          style: TextStyle(color: Colors.white)));
                } else if (snapshot.hasData) {
                  var castList = snapshot.data as List<Cast>;

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: castList.length,
                      itemBuilder: (context, index) {
                        return castItem(cast: castList[index]);
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    ),
  );
}

Widget castItem({required Cast cast}) {
  return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(children: [
        Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: cast.profilePath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${cast.profilePath}')
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset('assets/images/noImg.jpg', width: 80)),
            )),
        const SizedBox(height: 8),
        SizedBox(
            height: 40,
            child: Text(cast.name!, style: const TextStyle(fontSize: 10))),
      ]));
}
