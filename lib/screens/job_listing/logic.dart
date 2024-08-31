import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:job_portal/screens/job_listing/model.dart';
import 'dart:convert';

class HomeController extends GetxController {
  var photos = <Photo>[].obs;
  RxList filteredPhotos = <Photo>[].obs;

  var isLoading = true.obs;
  RxBool button = false.obs;
  RxBool star = false.obs;
  var bottomId = <int>[].obs;
  RxBool isSearch = false.obs;

  @override
  void onInit() {
    fetchPhotos();
    super.onInit();
  }

  void filterPhotos(String query) {
    print(query);
    if (query == "") {
      fetchPhotos();
    } else {
      final filtered = photos.where((photo) {
        final titleLower = photo.title.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
      filteredPhotos.value = filtered;
    }
  }

  void fetchPhotos() async {
    try {
      isLoading(true);
      final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;
        photos.value = jsonData.map((json) => Photo.fromJson(json)).toList();
        filteredPhotos = photos; // Initially display all photos
      } else {
        Get.snackbar('Error', 'Failed to fetch data');
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  void updateIconColor(int id) {
    if (!bottomId.contains(id)) {
      // Check if the index is not already in the list
      bottomId.add(id);
    }
  }
}
