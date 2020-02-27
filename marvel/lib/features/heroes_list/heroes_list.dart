import 'dart:convert';  
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/heroes.dart';
import 'package:pokedex/services/marvel_service.dart';
import 'heroes_list_cell.dart';

class HeroesListPage extends StatefulWidget {
  PokemonService service = PokemonServiceImpl();

  HeroesListPage([this.service]);

  @override
  _HeroesListPageState createState() => _HeroesListPageState();
}

class _HeroesListPageState extends State<HeroesListPage> {
  List<AllHeroesReponse> dataSource = [];

  @override
  initState() {
    super.initState();
    _dataSourceHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            "HEROES MARVEL",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey,
        ),
        child: Container(
            color: Colors.blueGrey.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: dataSource.isNotEmpty
                  ? ListView(
                      children: dataSource.map((heros) {
                        return Container(
                            height: 50,
                            child: HeroesListPageCell(
                              model: heros,
                            ));
                      }).toList(),
                    )
                  : Container(),
            )));
  }

  
  _dataSourceHeroes() {

  widget.service.fetchAllMavel().then((response) {
      var json = jsonDecode(response.body);
      List<AllHeroesReponse> heroesList = [];
      var list = json["data"]["results"];
        if (list != null) {
        for (var heroesJson in list) {
          var heroesResponse = AllHeroesReponse.fromMappedJson(heroesJson);
          heroesList.add(heroesResponse);  
        }
        setState(() {
          dataSource = heroesList;
        });
      }



    });
  }
  

}
