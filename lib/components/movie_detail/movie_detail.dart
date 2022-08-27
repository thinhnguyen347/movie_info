import 'package:flutter/material.dart';
import 'package:movie_slide/models/movie_info_model.dart';

import 'movie_detail_elements/detail_body.dart';

class MovieInDetail extends StatefulWidget {
  const MovieInDetail({Key? key}) : super(key: key);

  @override
  State<MovieInDetail> createState() => _MovieInDetailState();
}

class _MovieInDetailState extends State<MovieInDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MovieInfo selectedMovie =
        ModalRoute.of(context)!.settings.arguments as MovieInfo;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black87,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: const [
            Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.favorite_border))
          ],
        ),
        body: Stack(
          children: [
            Image.network(
                'https://image.tmdb.org/t/p/original${selectedMovie.backdropPath}',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width),
            Container(
                padding: const EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white.withOpacity(0.8)),
            body(context, selectedMovie),
          ],
        ));
  }
}
