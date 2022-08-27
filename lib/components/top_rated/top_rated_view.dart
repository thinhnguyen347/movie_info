import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../dataSrc/api_urls.dart';
import '../../models/movie_info_model.dart';

class TopRatedMovies extends StatefulWidget {
  const TopRatedMovies({Key? key}) : super(key: key);

  @override
  State<TopRatedMovies> createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovies> {
  Future<List<MovieInfo>>? topRatedList;

  @override
  void initState() {
    super.initState();
    topRatedList = getTopRatedMovie();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: topRatedList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }

          var listMoviesOnTopRatedTab = snapshot.data as List<MovieInfo>;

          return listMoviesOnTopRatedTab.isEmpty
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
                  itemCount: listMoviesOnTopRatedTab.length,
                  itemBuilder: (context, index) {
                    return movieItem(listMoviesOnTopRatedTab[index], context);
                  });
        });
  }
}

Widget movieItem(MovieInfo movie, context) {
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
                    Navigator.pushNamed(context, '/detail', arguments: movie);
                  },
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${movie.posterPath!}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
            ),
          )),
      const SizedBox(height: 8),
      SizedBox(
          height: 40,
          child: Text(movie.title!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white))),
    ],
  );
}

Future<List<MovieInfo>> getTopRatedMovie() async {
  List<MovieInfo> topRatedList = [];
  var apipUrl = ApiUrl.topRatedApiUrl;
  http.Response response;

  try {
    response = await http.get(apipUrl);
  } catch (e) {
    throw Exception('$e');
  }

  if (response.statusCode == 200) {
    var body = convert.jsonDecode(response.body) as Map<String, dynamic>;
    var results = body["results"];

    for (int i = 0; i < results.length; i++) {
      MovieInfo movie = MovieInfo.fromJson(results[i]);
      topRatedList.add(movie);
    }
  }

  return topRatedList;
}
