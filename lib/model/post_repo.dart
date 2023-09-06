import 'dart:convert';

import 'package:http/http.dart';

class PostRepo {
   fetchPosts(int page) async{
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$page');
    final response = await get(url);
    if(response.statusCode == 200){
       var json = jsonDecode(response.body) as List;
       return json ;
    }
    else {
      throw Exception('can\'t load posts');
    }
  }
}