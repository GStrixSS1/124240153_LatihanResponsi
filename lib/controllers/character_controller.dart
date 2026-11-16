import 'package:get/get.dart';
import '../models/character_model.dart';
import '../services/api_service.dart';

class CharacterController extends GetxController {
  final RxList<CharacterModel> characters = <CharacterModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxString selectedStatus = 'All'.obs;
  final RxString searchKeyword = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final results = await ApiService.getCharacters(
        status: selectedStatus.value,
        name: searchKeyword.value,
      );
      characters.assignAll(results);
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  void changeStatusFilter(String status) {
    if (selectedStatus.value != status) {
      selectedStatus.value = status;
      fetchCharacters();
    }
  }

  void searchByName(String query) {
    searchKeyword.value = query;
    fetchCharacters();
  }

  void clearSearch() {
    searchKeyword.value = '';
    fetchCharacters();
  }
}
