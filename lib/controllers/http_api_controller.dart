import 'package:get/get.dart';

class HttpApiController extends GetxController {
  var title = "HttpApiController".obs;
  // List<FontItem> fontItems = [];
  var api_get_posts = ''.obs;
  var api_get_posts_1 = ''.obs;
  var api_get_comments = ''.obs;
  var api_get_comments_1 = ''.obs;
  var api_post_posts = ''.obs;
  var api_put_posts = ''.obs;
  var api_patch_posts = ''.obs;
  var api_delete_posts = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
