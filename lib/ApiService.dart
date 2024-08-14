import 'dart:convert';
import 'package:http/http.dart' as http;
import '../movie.dart'; // Import file model

class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  final String bearerToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZjY0ZjkyMzQ3MGMyODA1OWE5OTUzYjM2ZWEzYzlmZSIsIm5iZiI6MTcxOTM2OTUxNy40NTA4MzMsInN1YiI6IjY2NmNmNDdmZjUyYzE3YTNkMjk5OTE1NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GEpGSY1XrpbSfIZbyBui_cffKOiIn4m8eqUPoCv4y_4';

  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'),
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List movies = data['results'];
      return movies.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
