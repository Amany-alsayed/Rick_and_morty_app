import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:rick_and_morty_app/business_logic/states.dart';
import 'package:rick_and_morty_app/constants/colors.dart';

import '../../business_logic/cubit.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
   List<Results> allCharacters=[];
   List<Results>searchedForCharacters=[];
  bool isSearching=false;
  final _searchTextController=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AppCubit>(context).getAllCharacters();
  }
  Widget _buildSearchField(){
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey,fontSize: 18),
      ),
      style:  const TextStyle(color: MyColors.myGrey,fontSize: 18),
      onChanged: (searchedCharacter){
        addSearchedForItemsToSearchedList(searchedCharacter);
      },

    );
  }
  void addSearchedForItemsToSearchedList(String searchedCharacter){

    searchedForCharacters=allCharacters.where((character) => character.name.toLowerCase().startsWith(searchedCharacter)).toList();
    setState(() {

    });
  }
  List<Widget>_buildAppBarAction(){
    if(isSearching){
      return[
        IconButton(
            onPressed: (){
              _clearSearch();
              Navigator.pop(context);
            },
            icon: const Icon( Icons.clear,color: MyColors.myGrey,),
        )
      ];
    }
    else{
      return[
        IconButton(
          onPressed:_startSearch,
          icon: const Icon( Icons.search,color: MyColors.myGrey,),
        )
      ];
    }
  }
  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove:_stopSearching));
    setState(() {
      isSearching=true;
    });
  }
  void _stopSearching(){
    _clearSearch();
    setState(() {
      isSearching=false;
    });
  }
  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }
  Widget _buildAppBarTitle(){
    return const Text(
      'Characters',
      style: TextStyle(
        color: MyColors.myGrey,
      ),
    );
  }

  Widget buildBlocWidget(){
    return BlocBuilder<AppCubit,AppState>(builder: (context,state){

      if(state is CharactersLoaded){
        allCharacters=(state).characters;
        return buildLoadedListWidget();
      }
      else{
        return showLoadingIndicator();
      }
    },
    );
  }
  Widget showLoadingIndicator(){
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }
  Widget buildLoadedListWidget(){
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }
  Widget buildCharacterList(){
    return GridView.builder(
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
          childAspectRatio: 2/3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        itemCount: isSearching?searchedForCharacters.length:allCharacters.length,
        physics: const ClampingScrollPhysics(),
        padding:EdgeInsets.zero,
        itemBuilder:(context,index){
          return CharacterItem(character:isSearching?searchedForCharacters[index]:allCharacters[index]);
        }
    );
  }
  Widget buildNoInternetWidget(){
    return Center(
      child: Container(
        color:Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
                'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: MyColors.myGrey,
              ),

            ),
            Image.asset('assets/images/online_connection.png',),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title:isSearching? _buildSearchField():_buildAppBarTitle(),
        leading: isSearching? const BackButton(color: MyColors.myGrey,):Container(),
        actions:_buildAppBarAction(),
      ),
      body: OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
          ) {
        final bool connected =connectivity!=ConnectivityResult.none;
        if(connected){
          return buildBlocWidget();
        }
        else{
          return buildNoInternetWidget();
        }
      },
        child: showLoadingIndicator(),
      ),

      // ,
    );
  }
}
