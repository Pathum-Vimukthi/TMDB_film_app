class Movie {
  String? posterPath;
  String? overView;
  int? id;
  String? title;
  String? backDropPath;

  Movie(
      {this.backDropPath, this.id, this.overView, this.posterPath, this.title});

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
        backDropPath: map['backdrop_path'],
        id: map['id'],
        overView: map['overview'],
        posterPath: map['poster_path'],
        title: map['title']);
  }
}
