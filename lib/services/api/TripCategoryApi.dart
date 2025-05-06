import 'package:app_mochila/data/category_data.dart';
import 'package:app_mochila/models/TripCategory.dart';
import 'package:app_mochila/services/api/API_Serveice.dart';

class TripCategoryApi extends APIService {
  TripCategoryApi({super.token, super.baseUrl});

  Future<List<TripCategory>> getAllCategories() async {
    final response = await getRequest('trip_categories');
    List<dynamic> tripCategoriesJson = response.data;
    return tripCategoriesJson
        .map((json) => TripCategory.fromJson(json))
        .toList();
  }

  Future<TripCategory> getCategoryByid(int tripCategoryId) async {
    final response = await getRequest('trip_categories/$tripCategoryId');
    return TripCategory.fromJson(response.data);
  }

  Future<TripCategory> createCategory(TripCategory tripCategory) async {
    final response =
        await postRequest('trip_categories', tripCategory.toJson());
    return TripCategory.fromJson(response.data);
  }

  Future<TripCategory> updateCategory(
      int categoryId, Map<String, dynamic> updateData) async {
    final response =
        await postRequest('trip_categories/$categoryId', updateData);
    return TripCategory.fromJson(response.data);
  }

  Future<TripCategory> deleteCategoryByid(int tripCategoryId) async {
    final response = await deleteRequest('trip_categories/$tripCategoryId');
    return TripCategory.fromJson(response.data);
  }

  Future<List<CategoryData>> getCategoryDataList() async {
    final response = await getRequest('trip_categories');
    List<dynamic> data = response.data;
    return data.map((json) => CategoryData.fromJson(json)).toList();
  }
}
