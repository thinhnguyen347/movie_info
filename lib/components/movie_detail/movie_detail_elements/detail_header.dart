import 'package:flutter/material.dart';

import '../../../models/movie_info_model.dart';

Widget header({required MovieInfo movie}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          flex: 1,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath!}'))),
      const SizedBox(width: 16),
      Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Phát hành:'),
                  const SizedBox(width: 8),
                  Text(movie.releaseDate!),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tên gốc:'),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Text(movie.originalTitle!),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Đánh giá:'),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Text('${movie.voteAverage}/10'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Độ phổ biến:'),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Text(movie.popularity.toString()),
                  ),
                ],
              ),
            ],
          )),
    ]),
  );
}
