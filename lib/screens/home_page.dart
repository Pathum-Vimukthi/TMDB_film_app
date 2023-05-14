import 'package:film_app/models/movies_model.dart';
import 'package:film_app/services/api_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService service = ApiService();
  List<Movie> movies = [];
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.menu),
                    Text(
                      "TMDB Movies",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    Icon(Icons.favorite)
                  ],
                ),
                FutureBuilder(
                  future: service.getMovies(page: page),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      movies = [...movies, ...snapshot.data!];
                      movies = movies.toSet().toList();
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.59,
                        ),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(
                                        "https://image.tmdb.org/t/p/w500${movies[index].posterPath}",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                movies[index].title.toString(),
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          );
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        page++;
                      });
                    },
                    child: const Text("Load More"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
