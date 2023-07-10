import 'package:app/src/models/category_model.dart';
import 'package:app/src/pages/home/repository/home_repository.dart';
import 'package:app/src/pages/home/result/home_result.dart';
import 'package:app/src/services/utils_services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // void printExample() {
  //   print('Funcionou!');
  // }

  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  bool isLoading = false;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  @override
  void onInit(){
    super.onInit();

    getAllCatgories();
  }

  void selectedCategory(CategoryModel category){
    currentCategory = category;
    update();
  }

  Future<void> getAllCatgories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult = await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if(allCategories.isEmpty) return;

        selectedCategory(allCategories.first);

        print('Todas as categorias: $allCategories');
      },
      error: (message) {
        utilsServices.showFlutterToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
