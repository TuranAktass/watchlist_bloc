import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:watchlist/feat/follow/repository/model/follow_user_model.dart';
import 'package:watchlist/feat/search/repository/model/search_model/search_response_model.dart';

class SearchProvider {
  final String url = 'http://www.omdbapi.com/?apikey=cebce6&s=';

  Future<SearchResponseModel> fetchSearchResult({String? query}) async {
    final response = await http.get(Uri.parse(url + query.toString()));
    if (response.statusCode == 200) {
      return SearchResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<FollowUserModel>> fetchUserSearchResult({String? query}) async {
    List<FollowUserModel> uList = [];

    await FirebaseFirestore.instance
        .collection('Users')
        .where('displayName', isEqualTo: query)
        .get()
        .then((value) {
      for (var element in value.docs) {
        uList.add(
            FollowUserModel.fromJson(json: element.data())..uid = element.id);
      }
    });

    return uList;
  }
}
