import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/business_logic/states.dart';
import 'package:rick_and_morty_app/data/repository/character_repository.dart';

class AppCubit extends Cubit<AppState>{
  final CharacterRepository characterRepository;
  AppCubit(this.characterRepository):super(InitialState());

void getAllCharacters(){
  int page=Random().nextInt(41);
    characterRepository.getAllCharacters(page+1).then((characters) {
      emit( CharactersLoaded(characters.results));
    });
}
}