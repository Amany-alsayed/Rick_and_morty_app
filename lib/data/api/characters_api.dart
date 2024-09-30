import 'package:dio/dio.dart';
import '../../constants/string.dart';

class CharactersApi{
  late Dio dio;
  CharactersApi(){
    BaseOptions options=BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio=Dio(options);
  }
  Future<Map<String,dynamic>>getAllCharacters(int page)async{
    try {
      Response response = await dio.get('character',queryParameters:{'page':page});

      // Check if the response was successful
      if (response.statusCode == 200) {
        print(response.data.toString());
        return response.data;
      } else {
        print('Failed to load characters. Status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Error: ${e.toString()}');
      return {};
    }
  }
  }

