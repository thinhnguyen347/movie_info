import 'dart:convert' as convert;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_slide/dataSrc/api_urls.dart';

import '../../models/movie_info_model.dart';

class UpcomingMovies extends StatefulWidget {
  const UpcomingMovies({Key? key}) : super(key: key);

  @override
  State<UpcomingMovies> createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovies> {
  Future<List<MovieInfo>>? upcomingMovie;

  @override
  initState() {
    super.initState();
    upcomingMovie = getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: upcomingMovie,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          var listMovies = snapshot.data as List<MovieInfo>;

          return listMovies.isEmpty
              ? const Center(
                  child: Text('Không có dữ liệu!',
                      style: TextStyle(color: Colors.white)))
              : CarouselSlider(
                  options: CarouselOptions(height: double.infinity),
                  items: listMovies.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                            child: movieItem(i, context));
                      },
                    );
                  }).toList(),
                );
        });
  }
}

Widget movieItem(MovieInfo movie, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath!}',
              fit: BoxFit.cover,
              width: double.infinity,
            )),
      ),
      const SizedBox(height: 8),
      SizedBox(
          height: 32,
          child: Text(movie.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white))),
      const SizedBox(height: 16),
      Expanded(
        flex: 1,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          scrollDirection: Axis.vertical,
          child: Text(movie.overview!,
              textAlign: TextAlign.start,
              style: const TextStyle(color: Colors.white)),
        ),
      )
    ],
  );
}

Future<List<MovieInfo>> getUpcomingMovies() async {
  List<MovieInfo> moviesList = [];
  http.Response response;
  var url = ApiUrl.upcomingApiUrl;

  try {
    response = await http.get(url);
  } catch (e) {
    throw Exception("$e");
  }

  if (response.statusCode == 200) {
    var body = convert.jsonDecode(response.body) as Map<String, dynamic>;
    var results = body["results"];

    for (int i = 0; i < results.length; i++) {
      MovieInfo movie = MovieInfo.fromJson(results[i]);
      moviesList.add(movie);
    }
  }

  return moviesList;
}
