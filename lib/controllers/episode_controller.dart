import 'package:get/get.dart';
import '../models/episode_model.dart';
import '../services/api_service.dart';

class EpisodeController extends GetxController {
  final RxList<EpisodeModel> episodes = <EpisodeModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEpisodes();
  }

  Future<void> fetchEpisodes() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final results = await ApiService.getEpisodes();
      episodes.assignAll(results);
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }
}
