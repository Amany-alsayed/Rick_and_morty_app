import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/constants/colors.dart';
import 'package:rick_and_morty_app/data/models/characters.dart';

class CharactersDetails extends StatelessWidget {
  final Results character;
  const CharactersDetails({super.key, required this.character});
Widget buildSliverAppBar(){
  return SliverAppBar(
    expandedHeight: 600,
    pinned: true,
    stretch: true,
    backgroundColor: MyColors.myGrey,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title:Text(
        character.name,
        style: const TextStyle(
            fontSize: 16,
            color:MyColors.myYellow,
            fontWeight: FontWeight.bold
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
      ),
      background: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          )
      ),
    ),
  );
}
Widget characterInfo(String title,String value){
  return RichText(
    maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )
          ),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 16,
              )
          ),
        ]
      ),
  );
}
Widget buildDivider(double endIndent){
  return Divider(
    height: 30,
    endIndent:endIndent ,
    color: MyColors.myYellow,
    thickness: 2,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: const EdgeInsets.fromLTRB( 14,14,14,0),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        characterInfo('status : ',character.status ),
                        buildDivider(290),
                        characterInfo('species : ',character.species ),
                        buildDivider(285),
                        characterInfo('gender : ',character.gender ),
                        buildDivider(285),
                        characterInfo('origin name : ',character.origin.name ),
                        buildDivider(240),
                        characterInfo('location name : ',character.location.name ),
                        buildDivider(220),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 500,
                  )
                ]
              )
          )
        ],
      ),
    );
  }
}
