import 'package:flutter/material.dart';

class GenreRow extends StatelessWidget {
  const GenreRow({Key? key, required this.genres}) : super(key: key);
  final String genres;

  @override
  Widget build(BuildContext context) {
    List<String> genreList = genres.split(',');
    return Row(
      children: List.generate(genreList.length, (index) {
        return _buildGenreCard(genreList[index]);
      }),
    );
  }

  _buildGenreCard(String genre) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(genre, style: const TextStyle(color: Colors.white)),
    );
  }
}
