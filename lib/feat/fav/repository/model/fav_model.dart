class FavResponseModel {
  List<FavModel> favList = [];
  String? error;

  FavResponseModel.withError(this.error);

  FavResponseModel({required List<Map<String, dynamic>> data}) {
    data.forEach((element) {
      favList.add(FavModel.fromJson(element));
    });
  }

  List<FavModel> get list => favList;
}

class FavModel {
  String? id;

  FavModel.fromJson(var json) {
    id = json['id'];
  }
}
