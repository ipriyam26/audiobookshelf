import 'package:audiobookshelf/Controller/home_controller.dart';
import 'package:audiobookshelf/Model/author_response/author_response.dart';
import 'package:audiobookshelf/Services/api_service.dart';
import 'package:audiobookshelf/Utils/filter.dart';
import 'package:get/get.dart';

extension AuthorSorting on List<Author> {
  // define sorting for author

  sortBy(SortAuthorItem criteria) {
    sort((b, a) {
      switch (criteria) {
        case SortAuthorItem.name:
          return a.name.compareTo(b.name);
        case SortAuthorItem.addedAt:
          return a.addedAt.compareTo(b.addedAt);
        case SortAuthorItem.numOfBooks:
          return (a.numBooks ?? 0).compareTo(b.numBooks ?? 0);
        default:
          return a.addedAt.compareTo(b.addedAt);
      }
    });
  }
}

class AuthorTabController extends GetxController {
  RxList<Author> authors = <Author>[].obs;
  RxBool isGridView = false.obs;
  ApiService apiService = ApiService();
  HomeController homeController = Get.find<HomeController>();
  Rx<SortAuthorItem> sort = SortAuthorItem.addedAt.obs;
  RxBool desc = true.obs;

  AuthorTabController() {
    authors.value = homeController.recentAuthors;
  }
  List<Author> sortAuthor(List<Author> authors) {
    return authors.sortBy(sort.value);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    // First-time loading, you could also use a FutureBuilder in the UI
    authors.value = await getLibraryAuthor();

    // Whenever sort value changes, sort the list
    ever(sort, (_) => authors.sortBy(sort.value));
    ever(desc, (_) {
      authors.value = authors.reversed.toList();
    });
  }

  Future<List<Author>> getLibraryAuthor() async {
    final response = await apiService.authenticatedGet(
        '/api/libraries/${homeController.dropdownValue.value.id}/authors');

    List<Author> recentAuthors = [];

    for (var author in response["authors"]) {
      Author recentAuthor = Author.fromMap(author);
      recentAuthors.add(recentAuthor);
    }
    return recentAuthors;
  }
}
