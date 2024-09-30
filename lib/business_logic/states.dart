import '../data/models/characters.dart';

abstract class AppState {

}
class InitialState extends AppState{}
class CharactersLoaded extends AppState{
  final List<Results>characters;

  CharactersLoaded(this.characters);
}