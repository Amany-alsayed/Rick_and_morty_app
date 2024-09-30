import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/business_logic/cubit.dart';
import 'package:rick_and_morty_app/data/api/characters_api.dart';
import 'package:rick_and_morty_app/data/models/characters.dart';
import 'package:rick_and_morty_app/data/repository/character_repository.dart';
import 'package:rick_and_morty_app/presentation/screens/charactersDetails.dart';
import 'package:rick_and_morty_app/presentation/screens/characters_screen.dart';
import 'constants/string.dart';
class AppRouter{
  Route? generateRoute(RouteSettings settings){

    switch(settings.name){
      case charactersScreen:
        return MaterialPageRoute(builder:(_)=>BlocProvider(
            create: (BuildContext context)=>AppCubit(CharacterRepository(CharactersApi())),
          child: const CharactersScreen(),
        )
        );
      case charactersDetails:
        final character= settings.arguments as Results;
        return MaterialPageRoute(builder:(_)=>CharactersDetails(character: character,)
        );
    }

  }

  }
