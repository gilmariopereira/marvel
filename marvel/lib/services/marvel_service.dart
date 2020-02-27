import 'package:http/http.dart' as http;

class BaseService {
  String baseURL = "https://pokeapi.co/api/v2";

  String publicKEY = '5ea3980f323cb76c1187caca74afd66f';
  String privateKEY = 'e4602bd9a88ad1a9b997be30d76a3a61d2af4a3a';
  String param = "?ts=1&apikey=5ea3980f323cb76c1187caca74afd66f&hash=efacbc2a5a95762df94f3fdf32518629";


  String baseURLAPI = "http://gateway.marvel.com/v1/public/";

  String formURL(String endpoint) {
    return "$baseURL$endpoint";
  }

  String formAPI(String endpoint) {
    return "$baseURLAPI$endpoint$param";
  }
}

abstract class PokemonService {
  Future<http.Response> fetchAllKantoPokemon();
  Future<http.Response> fetchPokemonWithName({String name});
  Future<http.Response> fetchAllMavel();
  Future<http.Response> fetchAllMavelWithId(String id);


  String imageNameForID({String id});


}

class PokemonServiceImpl extends BaseService implements PokemonService {
  @override
  Future<http.Response> fetchAllKantoPokemon() {
    return http.get(formURL("/pokemon?limit=151"));
  }

  @override
  String imageNameForID({String id}) {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
  }

  @override
  Future<http.Response> fetchPokemonWithName({String name}) {
    return http.get(formURL("/pokemon/$name/"));
  }

 @override
  Future<http.Response> fetchAllMavel() {
    return http.get(formAPI("characters"));
  }

  @override
  Future<http.Response> fetchAllMavelWithId(String id) {
    return http.get(formAPI("characters/$id"));
  }


}
