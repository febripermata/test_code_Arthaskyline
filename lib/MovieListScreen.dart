import 'package:flutter/material.dart';
import 'ApiService.dart'; 
import 'movie.dart'; 

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late Future<List<Movie>> movies;

  @override
  void initState() {
    super.initState();
    movies = ApiService().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return ListTile(
                  leading: Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                  title: Text(movie.title),
                  subtitle: Text(movie.overview, maxLines: 2, overflow: TextOverflow.ellipsis),
                );
              },
            );
          } else {
            return Center(child: Text('No movies found'));
          }
        },
      ),
    );
  }
}
