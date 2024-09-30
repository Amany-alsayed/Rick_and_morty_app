import 'package:rick_and_morty_app/data/api/characters_api.dart';

import '../models/characters.dart';

class CharacterRepository{
final CharactersApi charactersApi;

  CharacterRepository(this.charactersApi);
Future<Character>getAllCharacters(int page)async{
  final characters=await charactersApi.getAllCharacters(page);

   return Character.fromJson(characters);
}
}