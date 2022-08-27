import 'package:flutter/material.dart';
import 'package:movie_slide/models/movie_info_model.dart';

class MovieListProvider with ChangeNotifier {
  List<MovieInfo> movieList = [];
  late MovieInfo _selectedMovie;

  get selectedMovie => _selectedMovie;

  updateMovieToProvider({required List<MovieInfo> movieList}) {
    this.movieList = movieList;
  }

  updateSelectedMovie({required int index}) {
    _selectedMovie = movieList[index];
    notifyListeners();
  }
}
