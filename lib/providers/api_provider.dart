import 'package:flutter/material.dart';
import 'package:flutterprueba/models/character.model.dart';
import 'package:http/http.dart' as http;
import 'package:flutterprueba/models/episode.model.dart';

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];
  List<EpisodeResponse> episodes = [];

  Future<void> getCharacters(int page) async {
    final result = await http.get(Uri.https(url, '/api/character', {
      'page': page.toString(),
    }));
    final response = characterResponseFromJson(result.body);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, '/api/character/', {'name': name}));
    final response = characterResponseFromJson(result.body);
    return response.results!;
  }

  Future<List<EpisodeResponse>> getEpisodes(Character character) async {
    episodes = [];
    for (int i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeResponseFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }
    return episodes;
  }
}
