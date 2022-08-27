import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_slide/dataSrc/api_urls.dart';
import 'package:movie_slide/models/movie_info_model.dart';

import '../../models/movie_info_model.dart';

class PopularView extends StatefulWidget {
  const PopularView({Key? key}) : super(key: key);

  @override
  State<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  Future<List<MovieInfo>>? moviesList;

  @override
  void initState() {
    super.initState();
    moviesList = getPopularMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: moviesList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          var listMoviesOnPopularTab = snapshot.data as List<MovieInfo>;

          return listMoviesOnPopularTab.isEmpty
              ? const Center(
                  child: Text('Không có dữ liệu!',
                      style: TextStyle(color: Colors.white)))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16),
                  itemCount: listMoviesOnPopularTab.length,
                  itemBuilder: (context, index) {
                    return itemPopular(listMoviesOnPopularTab[index], context);
                  });
        });
  }
}

Widget itemPopular(MovieInfo itemPopular, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail',
                        arguments: itemPopular);
                  },
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${itemPopular.posterPath!}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
            ),
          )),
      const SizedBox(height: 8),
      SizedBox(
          height: 40,
          child: Text(itemPopular.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white))),
    ],
  );
}

Future<List<MovieInfo>> getPopularMovies() async {
  List<MovieInfo> videoList = [];
  var url = ApiUrl.popularMovieApiUrl;
  http.Response response;

  try {
    response = await http.get(url);
  } catch (e) {
    throw Exception('Error: $e');
  }

  if (response.statusCode == 200) {
    var body = convert.jsonDecode(response.body) as Map;
    var movies = body['results'];

    for (int i = 0; i < movies.length; i++) {
      MovieInfo movie = MovieInfo.fromJson(body['results'][i]);
      videoList.add(movie);
    }
  }

  return videoList;
}
