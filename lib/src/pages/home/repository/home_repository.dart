import 'package:app/src/constants/endpoints.dart';
import 'package:app/src/models/category_model.dart';
import 'package:app/src/pages/home/result/home_result.dart';
import 'package:app/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      // Lista
      List<CategoryModel> data =
          (result['result'] as List<Map<String, dynamic>>)
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      // Erro
      return HomeResult.error("Ocorreu um erro inesperado ao recuperar as categorias");
    }
  }
}
