import 'package:flutter/material.dart';
import 'package:movie_slide/models/movie_info_model.dart';

import 'detail_cast.dart';
import 'detail_description.dart';
import 'detail_header.dart';

Widget body(BuildContext context, MovieInfo selectedMovie) {
  return ListView(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    children: [
      const SizedBox(height: 20),
      header(movie: selectedMovie),
      const SizedBox(height: 20),
      cast(id: selectedMovie.id, context: context),
      const SizedBox(height: 20),
      movieDescription(description: selectedMovie.overview!),
      const SizedBox(height: 20),
    ],
  );
}
